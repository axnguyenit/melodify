import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class YTMSectionItem {
  final String id;
  final String title;
  final String subtitle;
  final YTMSectionItemType type;
  final List<YTMSectionItemThumbnail> thumbnails;

  YTMSectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.thumbnails,
  });

  factory YTMSectionItem.fromJson(Map<String, dynamic> json) {
    try {
      log.trace('Parsing YTMSectionItem');
      Map<String, dynamic> renderer = {};
      String title = '';
      String subtitle = '';
      List thumbnails = [];

      // if (!json.containsKey('musicResponsiveListItemRenderer')) {
      //   log
      //     ..trace('Do not contain musicResponsiveListItemRenderer')
      //     ..logMap(json);
      // }

      if (json.containsKey('musicResponsiveListItemRenderer')) {
        renderer = getValue<Map<String, dynamic>>(
          json,
          ['musicResponsiveListItemRenderer'],
        );

        final flexColumns = getValue<List>(renderer, ['flexColumns'], []);
        const flexColumnRenderKey = 'musicResponsiveListItemFlexColumnRenderer';
        title = getRunsText(flexColumns.first[flexColumnRenderKey]);
        subtitle = getRunsText(flexColumns[1][flexColumnRenderKey]);
        thumbnails = getValue<List>(
          renderer,
          [
            'thumbnail',
            'musicThumbnailRenderer',
            'thumbnail',
            'thumbnails',
          ],
          [],
        );
      } else {
        renderer = getValue<Map<String, dynamic>>(
          json,
          ['musicTwoRowItemRenderer'],
        );
        title = getRunsText(renderer, key: 'title');
        subtitle = getRunsText(renderer, key: 'subtitle');
        thumbnails = getValue<List>(
          renderer,
          [
            'thumbnailRenderer',
            'musicThumbnailRenderer',
            'thumbnail',
            'thumbnails',
          ],
          [],
        );
      }
      log.trace('Parsing flexColumns');
      final typeValue = subtitle.split('•').first.trim().toLowerCase();
      final type = YTMSectionItemType.fromValue(typeValue);
      log.trace('Parsing thumbnails');

      String id;
      // log
      //   ..warning(renderer['playlistItemData'])
      //   ..warning(renderer['navigationEndpoint']);
      List keys = [];
      if (type.isStation) {
        keys = ['navigationEndpoint', 'watchEndpoint', 'videoId'];
      } else if (type.isSong || type.isVideo) {
        keys = ['playlistItemData', 'videoId'];
      } else {
        keys = ['navigationEndpoint', 'browseEndpoint', 'browseId'];
      }

      log.trace('Parsing id');
      id = getValue<String>(renderer, keys, '');

      return YTMSectionItem(
        id: id,
        title: title,
        subtitle: subtitle,
        type: type,
        thumbnails: thumbnails.map((thumbnail) {
          return YTMSectionItemThumbnail.fromJson(thumbnail);
        }).toList(),
      );
    } catch (e) {
      log.error('Parse YTMSectionItem Error --> $e');
      rethrow;
    }
  }
}
