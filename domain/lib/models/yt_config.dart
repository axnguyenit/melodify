import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class YTConfig {
  final String gapiHost;
  final String gapiLocale;
  final String gl;
  final String hl;
  final InnerTubeClient innerTubeClient;
  final String innerTubeApiKey;
  final String serverName;
  final String signinUrl;
  final String visitorData;
  final String xsrfFieldName;
  final String xsrfToken;
  final String serverVersion;
  final String locale;
  final bool reuseComponents;
  final String datasyncId;
  final String clientConfigData;
  final String appInstallData;
  final String coldConfigData;
  final String coldHashData;
  final String hotHashData;
  final String initialEndpoint;
  final String audioQuality;

  YTConfig({
    required this.gapiHost,
    required this.gapiLocale,
    required this.gl,
    required this.hl,
    required this.innerTubeClient,
    required this.innerTubeApiKey,
    required this.serverName,
    required this.signinUrl,
    required this.visitorData,
    required this.xsrfFieldName,
    required this.xsrfToken,
    required this.serverVersion,
    required this.locale,
    required this.reuseComponents,
    required this.datasyncId,
    required this.clientConfigData,
    required this.appInstallData,
    required this.coldConfigData,
    required this.coldHashData,
    required this.hotHashData,
    required this.initialEndpoint,
    required this.audioQuality,
  });

  factory YTConfig.fromJson(Map<String, dynamic> json) {
    try {
      return YTConfig(
        gapiHost: json['GAPI_LOCALE'],
        gapiLocale: json['GAPI_LOCALE'],
        gl: json['GL'],
        hl: json['HL'],
        innerTubeClient: InnerTubeClient.fromJson(
          json['INNERTUBE_CONTEXT']['client'],
        ),
        innerTubeApiKey: json['INNERTUBE_API_KEY'],
        serverName: json['SERVER_NAME'],
        signinUrl: json['SIGNIN_URL'],
        visitorData: json['VISITOR_DATA'],
        xsrfFieldName: json['XSRF_FIELD_NAME'],
        xsrfToken: json['XSRF_TOKEN'],
        serverVersion: json['SERVER_VERSION'],
        locale: json['LOCALE'],
        reuseComponents: json['REUSE_COMPONENTS'],
        datasyncId: json['DATASYNC_ID'],
        clientConfigData: json['SERIALIZED_CLIENT_CONFIG_DATA'],
        appInstallData: getValue<String>(json, [
          'INNERTUBE_CONTEXT',
          'client',
          'configInfo',
          'appInstallData',
        ]),
        coldConfigData: json['RAW_COLD_CONFIG_GROUP']['configData'],
        coldHashData: json['SERIALIZED_COLD_HASH_DATA'],
        hotHashData: json['SERIALIZED_HOT_HASH_DATA'],
        initialEndpoint: json['INITIAL_ENDPOINT'],
        audioQuality: json['AUDIO_QUALITY'],
      );
    } catch (e) {
      log.error('Parse YTConfig Error --> $e');
      rethrow;
    }
  }
}
