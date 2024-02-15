import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class MusicCarouselShelf extends Model {
  final MusicCarouselShelfHeader header;
  final List<YTMSectionItem> contents;
  final int numItemsPerColumn;
  final MusicShelfRendererType rendererType;

  MusicCarouselShelf({
    required this.header,
    required this.contents,
    required this.numItemsPerColumn,
    required this.rendererType,
  });

  factory MusicCarouselShelf.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('musicCarouselShelfRenderer')) {
        log
          ..error('Do not contain key musicCarouselShelfRenderer')
          ..logMap(json);
      }
      final renderer = json['musicCarouselShelfRenderer'];
      final contents = getValue<List>(
        renderer,
        ['contents'],
        [],
      );
      return MusicCarouselShelf(
        header: MusicCarouselShelfHeader.fromJson(renderer['header']),
        contents: contents.map((content) {
          return YTMSectionItem.fromJson(content);
        }).toList(),
        numItemsPerColumn: int.parse(
          getValue<String>(
            renderer,
            ['numItemsPerColumn'],
            '1',
          ),
        ),
        rendererType: contents.first.containsKey('musicTwoRowItemRenderer')
            ? MusicShelfRendererType.twoRowItem
            : MusicShelfRendererType.responsiveListItem,
      );
    } catch (e) {
      log.error('Parse MusicCarouselShelf error --> $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [];
}

// ════════════════════════════════════════════
class MusicCarouselShelfHeader {
  final String? title;
  final String? strapline;
  final String? label;
  final MoreContentButton? moreContentButton;

  MusicCarouselShelfHeader({
    this.title,
    this.strapline,
    this.label,
    this.moreContentButton,
  });

  factory MusicCarouselShelfHeader.fromJson(Map<String, dynamic> json) {
    try {
      final renderer = json['musicCarouselShelfBasicHeaderRenderer'];

      return MusicCarouselShelfHeader(
        title: getRunsText(renderer, key: 'title'),
        label: getValue<String>(
          renderer,
          ['accessibilityData', 'accessibilityData', 'label'],
          '',
        ),
        strapline: getRunsText(renderer, key: 'strapline'),
        moreContentButton: renderer['moreContentButton'] == null
            ? null
            : MoreContentButton.fromJson(renderer['moreContentButton']),
      );
    } catch (e) {
      log.error('Parse MusicCarouselShelfHeader error --> $e');
      rethrow;
    }
  }
}

// ════════════════════════════════════════════

class MoreContentButton {
  final String label;
  final String clickTrackingParams;
  final String trackingParams;

  MoreContentButton({
    required this.label,
    required this.clickTrackingParams,
    required this.trackingParams,
  });

  factory MoreContentButton.fromJson(Map<String, dynamic> json) {
    try {
      final renderer = json['buttonRenderer'];

      return MoreContentButton(
        label: getValue<String>(
          renderer,
          ['accessibilityData', 'accessibilityData', 'label'],
        ),
        trackingParams: getValue<String>(
          renderer,
          ['trackingParams'],
        ),
        clickTrackingParams: getValue<String>(
          renderer,
          ['navigationEndpoint', 'clickTrackingParams'],
        ),
      );
    } catch (e) {
      log.error('Parse MoreContentButton error --> $e');
      rethrow;
    }
  }
}

/// watchPlaylistEndpoint, browseEndpoint, watchEndpoint

// "navigationEndpoint": {
//                       "clickTrackingParams": "CJADEOvLBSITCIyOvuO0kYQDFfO3VgEd_hoCpg==",
//                       "browseEndpoint": {
//                         "browseId": "FEmusic_moods_and_genres_category",
//                         "params": "ggMPOg1uX1BmNzc2V2p0YXJ5"
//                       }
//                     },

// "navigationEndpoint": {
//               "clickTrackingParams": "CO0EEI_wCiITCJP8pPSykYQDFUq2VgEd4DMLfA==",
//               "watchPlaylistEndpoint": {
//                 "playlistId": "RDAMVMReZtxVazY6Y",
//                 "params": "KgtSZVp0eFZhelk2WSoLbGlJUF9IUFhyZHMqC2xFa3JkS1N0cEh3KgtsejN2MjNuX3B6byoLN3lHSUlURFhRVFUqC08wZG16alNuaHpZKgtHcVdZSlQtaU1UdyoLQ19oN3dXcktzQ1UqC3E0dlBtMmVpSEc0Kgt0T1pvQXNKTzAwdyoLbTFkNmI2ZWpoOXcqC1JSZG13X0hpdzd3KgtYZkVNai16M1R0QSoLZHNOYnp5VV8xUkkqC3MtQVpJdDJaYXVJKgtNdURFUk5FeEZMbyoLd1NPYzVqbXZGLWsqC05KbzF6ZnlYTnU4Kgtzbng1cUdVdFZpOPIBAngB"
//               }
//             },