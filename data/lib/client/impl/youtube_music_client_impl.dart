import 'dart:convert';

import 'package:data/client/base_client.dart';
import 'package:data/client/client.dart';
import 'package:data/configs/config.dart';
import 'package:data/preferences/app_references.dart';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: YoutubeMusicClient)
class YoutubeMusicClientImpl extends BaseClient implements YoutubeMusicClient {
  YoutubeMusicClientImpl(AppPreferences appPreferences)
      : super(Config().youtubeMusicUrl, appPreferences);

  static const _userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36';

  static const _contentType = 'application/json';

  @override
  Future<String?> getVisitorId(Map<String, String> headers) async {
    return null;
  }

  @override
  Future<HomeData> getHome({required String localeCode}) async {
    final response = await http.get(
      Uri.parse(Config().youtubeMusicUrl),
      headers: {
        'User-Agent': _userAgent,
        'Content-Type': _contentType,
        'Accept-Language': localeCode,
      },
    );

    final ytConfigReg = RegExp(r'ytcfg\.set\s*\(\s*({.+?})\s*\)\s*;');
    final matchedYtConfig = ytConfigReg.firstMatch(response.body);
    final ytConfigJson = jsonDecode(matchedYtConfig!.group(1).toString());
    final ytConfig = YTConfig.fromJson(ytConfigJson);
    final dataReg = RegExp(
        r"JSON\.parse\('\\x7b\\x22browseId\\x22:\\x22FEmusic_home\\x22\\x7d'\)\s*,\s*data\s*:\s*'\s*(.+?)\s*'}\);\s*ytcfg\.set\s*\(\s*");
    final matchedData = dataReg.firstMatch(response.body.toString());
    final extractedString = matchedData!.group(1);
    final convertedString = extractedString!
        .replaceAllMapped(
          RegExp(r'\\x([0-9a-fA-F]{2})'),
          (Match match) => String.fromCharCode(
            int.parse(match.group(1)!, radix: 16),
          ),
        )
        .replaceAll('\\"', '"') // Escape double quotes
        .replaceAll(r'\n', '\n') // Use platform-specific newline escape
        .replaceAll(
            r'\r\n', '\n') // Handle Windows-style newlines (if applicable)
        // Address other escape sequences or character conversions as necessary
        .replaceAll(r'\t', '    ');
    final parsedContentMap = jsonDecode(convertedString);
    final content = Content.fromJson(parsedContentMap, firstBrowse: true);
    return HomeData(ytConfig: ytConfig, content: content);
  }

  @override
  Future<Content> browse(BrowseRequest request) async {
    final json = await post(
      '/youtubei/v1/browse',
      queries: request.toQueries(),
      data: request.toPayload(),
    );

    return Content.fromJson(json);
  }

  @override
  Future<YTMSearchResult> getSearchResults(SearchResultRequest request) async {
    final json = await post(
      '/youtubei/v1/search',
      headers: {
        'user-agent': _userAgent,
        'cookie': 'CONSENT=YES+cb',
        'accept': '*/*',
        // 'origin': Config().youtubeMusicUrl,
        'accept-language': 'en-US,en;q=0.9',
        'sec-fetch-dest': 'document',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-site': 'none',
        'sec-fetch-user': '?1',
        'sec-gpc': '1',
        'upgrade-insecure-requests': '1',
      },
      queries: request.toQueries(),
      // queries: {
      //   'alt': 'json',
      // },
      data: request.toPayload(),
    );

    return YTMSearchResult.fromJson(json);
  }

  @override
  Future<MusicCarouselShelf> getMusicCarouselShelf() async {
    const path = 'packages/data/mocks/music_carousel_shelf.json';
    final byteData = await rootBundle.load(path);
    final data = utf8.decode(byteData.buffer.asUint8List());
    final result = Map<String, dynamic>.from(json.decode(data));

    return MusicCarouselShelf.fromJson(result);
  }

  @override
  Future<VideoDetails> player({required GetPlayerRequest request}) async {
    final json = await post(
      '/youtubei/v1/player',
      headers: {
        'User-Agent':
            'com.google.android.youtube/17.36.4 (Linux; U; Android 12; GB) gzip',
        'Content-Type': _contentType,
      },
      data: request.toPayload(),
    );

    return VideoDetails.fromJson(json);
  }
}
