import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

/// YTM = 'YouTube Music'
class YTMSearchResult {
  final List<YTMSearchSection> sections;

  YTMSearchResult({required this.sections});

  factory YTMSearchResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('contents')) {
      log.trace('YTM return empty data');
      return YTMSearchResult(sections: List.empty());
    }

    try {
      final contents = getValue<List<dynamic>>(json, [
        'contents',
        'tabbedSearchResultsRenderer',
        'tabs',
        0,
        'tabRenderer',
        'content',
        'sectionListRenderer',
        'contents'
      ], []);

      return YTMSearchResult(
        sections: contents.map((content) {
          return YTMSearchSection.fromJson(
            {
              'title': getRunsText(content['musicShelfRenderer'], key: 'title'),
              'items': content['musicShelfRenderer']['contents'],
            },
          );
        }).toList(),
      );
    } catch (e) {
      log.error('Parse YTMSearchResult error --> $e');
      rethrow;
    }
  }
}
