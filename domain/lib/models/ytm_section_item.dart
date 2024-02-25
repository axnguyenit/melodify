import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class YTMSectionItem {
  final String id;
  final String title;
  final String subtitle;
  final YTMSectionItemType type;
  final List<Thumbnail> thumbnails;
  final AspectRatioEnum aspectRatio;
  final ThumbnailCornerOverlay? thumbnailCornerOverlay;
  final Menu menu;
  final ThumbnailOverlay overlay;

  YTMSectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.thumbnails,
    required this.aspectRatio,
    required this.thumbnailCornerOverlay,
    required this.menu,
    required this.overlay,
  });

  factory YTMSectionItem.fromJson(Map<String, dynamic> json) {
    try {
      Map<String, dynamic> renderer = {};
      String title = '';
      String subtitle = '';
      List thumbnails = [];
      AspectRatioEnum aspectRatio = AspectRatioEnum.square;
      ThumbnailCornerOverlay? thumbnailCornerOverlay;
      String? id;
      ThumbnailOverlay? overlay;

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
        final titleRenderer = flexColumns.first[flexColumnRenderKey];
        // final watchEndpoint = getValue<Map<String, dynamic>>(
        //   titleRenderer,
        //   ['text', 'runs', 0, 'navigationEndpoint', 'watchEndpoint'],
        // );
        id = getValue<String>(renderer, ['playlistItemData', 'videoId']);
        // playlistId = getValue(watchEndpoint, ['playlistId']);
        title = getRunsText(titleRenderer);
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
        overlay = ThumbnailOverlay.fromJson(renderer['overlay']);
      } else {
        if (!json.containsKey('musicTwoRowItemRenderer')) {
          log.error('Do not contain key musicTwoRowItemRenderer');
        }
        renderer = getValue<Map<String, dynamic>>(
          json,
          ['musicTwoRowItemRenderer'],
        );
        // final browseEndpoint = getValue<Map<String, dynamic>>(
        //   renderer,
        //   ['title', 'runs', 0, 'navigationEndpoint', 'browseEndpoint'],
        // );
        // id = getValue(browseEndpoint, ['browseId'], '');
        // playlistId = getValue(browseEndpoint, ['playlistId']);
        title = getRunsText(renderer, key: 'title');
        subtitle = getRunsText(renderer, key: 'subtitle');
        aspectRatio = AspectRatioEnum.fromValue(
          getValue<String?>(renderer, ['aspectRatio']),
        );
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
        final thumbnailCornerOverlayMap =
            getValue(renderer, ['thumbnailCornerOverlay']);
        if (thumbnailCornerOverlayMap != null) {
          thumbnailCornerOverlay =
              ThumbnailCornerOverlay.fromJson(thumbnailCornerOverlayMap);
        }
        overlay = ThumbnailOverlay.fromJson(renderer['thumbnailOverlay']);
      }
      final typeValue = subtitle.split('•').first.trim().toLowerCase();
      final type = YTMSectionItemType.fromValue(typeValue);

      List keys = [];
      if (type.isStation) {
        keys = ['navigationEndpoint', 'watchEndpoint', 'videoId'];
      } else if (type.isSong || type.isVideo) {
        keys = ['playlistItemData', 'videoId'];
      } else {
        keys = ['navigationEndpoint', 'browseEndpoint', 'browseId'];
      }

      id ??= getValue<String>(renderer, keys, '');

      return YTMSectionItem(
        id: id,
        title: title,
        subtitle: subtitle,
        type: type,
        thumbnails: thumbnails.map((thumbnail) {
          return Thumbnail.fromJson(thumbnail);
        }).toList(),
        aspectRatio: aspectRatio,
        thumbnailCornerOverlay: thumbnailCornerOverlay,
        menu: Menu.fromJson(getValue(renderer, ['menu'])),
        overlay: overlay,
      );
    } catch (e) {
      log.error('Parse YTMSectionItem Error --> $e');
      rethrow;
    }
  }
}
