import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:data/configs/config.dart';
import 'package:data/data.dart';
import 'package:data/preferences/app_references.dart';
import 'package:http/http.dart';
import 'package:retry/retry.dart';

// ────────────────────────────────────────────

abstract class BaseClient {
  final Client _client;
  final String _baseUrl;
  final AppPreferences? _appPreferences;

  BaseClient(String baseUrl, [AppPreferences? appPreferences])
      : _client = Client(),
        _baseUrl = baseUrl,
        _appPreferences = appPreferences;

  String get apiVersion => Config().apiVersion;

  Uri _getParsedUrl(String path, [Map<String, dynamic>? queries]) {
    final url = _baseUrl.replaceAll(RegExp(r'^(https?://)'), '');
    return Uri.https(url, path, queries);
  }

  void _setHeaders(
    BaseRequest request, {
    Map<String, String>? headers,
  }) {
    final accessToken = _appPreferences?.accessToken;

    request.headers['Content-Type'] = 'application/json';
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    final profileToken = _appPreferences?.profileToken;
    if (profileToken != null) {
      request.headers['x-profile-token'] = 'Bearer $profileToken';
    }

    if (headers != null) {
      headers.forEach((key, value) {
        request.headers[key] = value;
      });
    }

    log.info('CALL API: ', messages: [
      '─ API URL ──> ${request.url}',
      '─ AUTHORIZATION ──> ${request.headers}',
    ]);
  }

  Future<dynamic> _call(
    String method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async {
    try {
      final request = Request(method, _getParsedUrl(path, queries));
      _setHeaders(request, headers: headers);
      if (data != null) {
        request.body = jsonEncode(data);
        log.info('PAYLOAD ──> ${request.body}');
      }
      _logRequest(request);
      return retry(
        () async {
          final response = await _client
              .send(request)
              .timeout(const Duration(seconds: 30))
              .then(Response.fromStream);
          return _responseInterceptor(response);
        },
        retryIf: (e) async {
          return false;
        },
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  void _logRequest(Request request) {
    final uri = request.url;
    final method = request.method;
    log
      ..logMapAsTable(
        {
          'Method': method,
          'Url': uri.toString(),
        },
        header: 'REQUEST',
      )
      ..logMapAsTable(request.headers, header: 'HEADERS');
  }

  void _logResponse(Response response) {
    final uri = response.request?.url;
    final method = response.request?.method;
    log.logMapAsTable(
      {
        'Method': method,
        'Status Code': response.statusCode,
        'Url': uri.toString(),
      },
      header: 'RESPONSE',
    );

    // final responseBody = jsonDecode(response.body);
    // if (responseBody is Map) {
    //   log.logMap(responseBody);
    // } else if (responseBody is Uint8List) {
    //   log.logUint8List(responseBody);
    // } else if (responseBody is List) {
    //   log
    //     ..topDivider()
    //     ..logList(responseBody)
    //     ..bottomDivider();
    // } else {
    //   log.logBlock(responseBody.toString());
    // }
  }

  dynamic _responseInterceptor(Response response) {
    _logResponse(response);

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException('BadRequestException');
      case 401:
      // handle refresh token
      // _client.send(response.request!);
      case 403:
        {
          log.error('AUTHORIZATION: ', messages: [
            '─ ACCESS TOKEN ──> ${_appPreferences?.accessToken}',
            '─ PROFILE TOKEN ──> ${_appPreferences?.profileToken}',
          ]);

          throw UnauthorizedException('UnauthorizedException');
        }
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      case 501:
        throw ServerErrorException('ServerErrorException');
      default:
        throw AppException.fromJson();
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) {
    return _call(
      'GET',
      path,
      queries: queries,
      headers: headers,
    );
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) {
    return _call(
      'POST',
      path,
      data: data,
      queries: queries,
      headers: headers,
    );
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) {
    return _call(
      'PUT',
      path,
      data: data,
      queries: queries,
      headers: headers,
    );
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) {
    return _call(
      'DELETE',
      path,
      data: data,
      queries: queries,
      headers: headers,
    );
  }

  Future<StreamedResponse> postWithFile(
    String path, {
    Map<String, dynamic>? data,
    required MultipartFile file,
    Map<String, String>? headers,
  }) {
    final request = MultipartRequest('POST', _getParsedUrl(path));
    _setHeaders(request, headers: headers);

    if (data != null) {
      data.forEach((key, value) {
        request.fields[key] = jsonEncode(value);
      });
    }

    request.files.add(file);
    return request.send();
  }

  Future<dynamic> uploadFileWithProgress(
    String path, {
    Map<String, dynamic>? data,
    required MultipartFile file,
    void Function(double)? uploading,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _getParsedUrl(path);
      final request = UploadMultipartRequest(
        'POST',
        uri,
        onProgress: (int bytes, int total) {
          final progress = 100.0 * (bytes / total);
          if (uploading != null) uploading(progress * 0.95);
        },
      );

      _setHeaders(request, headers: headers);
      request.files.add(file);

      final response = await request.send().then(Response.fromStream);
      if (uploading != null) uploading(100.0);

      return _responseInterceptor(response);
    } on ClientException catch (e) {
      log.error('ERROR OCCURRED WHILE SENDING FILE TO API, ${e.message}');
      throw BadRequestException(e.message);
    } catch (e) {
      log.error('ERROR OCCURRED WHILE SENDING FILE TO API');
      rethrow;
    }
  }

  Future<Uint8List> downloadFileWithProgress(
    String path, {
    void Function(double)? downloading,
  }) async {
    final completer = Completer<Uint8List>();
    try {
      final List<int> bytes = [];
      final request = Request('GET', Uri.parse(path));
      final response = await request.send();
      final total = response.contentLength ?? 0;

      response.stream.listen((value) {
        bytes.addAll(value);
        final progress = 100.0 * (bytes.length / total);
        if (downloading != null) {
          downloading(progress);
        }
      }).onDone(() async {
        completer.complete(Uint8List.fromList(bytes));
      });
    } on ClientException catch (e) {
      log.error('ERROR OCCURRED WHILE DOWNLOADING FILE FROM API, ${e.message}');
      completer.completeError(BadRequestException(e.message));
    } catch (e) {
      log.error('ERROR OCCURRED WHILE DOWNLOADING FILE FROM API');
      completer.completeError(e);
    }
    return completer.future;
  }
}

// ────────────────────────────────────────────

class UploadMultipartRequest extends MultipartRequest {
  /// Creates a new [MultipartRequest].
  UploadMultipartRequest(
    super.method,
    super.url, {
    this.onProgress,
  });

  final void Function(int bytes, int totalBytes)? onProgress;

  /// Freezes all mutable fields and returns a
  /// single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    var bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress?.call(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return ByteStream(stream);
  }
}
