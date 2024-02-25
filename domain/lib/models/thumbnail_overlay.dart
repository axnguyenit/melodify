import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class ThumbnailOverlay {
  final List<String> gradientLayerColors;
  final OverlayPosition position;
  final PlayNavigationEndpoint playNavigationEndpoint;

  ThumbnailOverlay({
    required this.gradientLayerColors,
    required this.position,
    required this.playNavigationEndpoint,
  });

  factory ThumbnailOverlay.fromJson(Map<String, dynamic> json) {
    try {
      final overlayRenderer =
          getValue(json, ['musicItemThumbnailOverlayRenderer']);

      final gradientLayerColorsJson = getValue<List>(
        overlayRenderer,
        ['background', 'verticalGradient', 'gradientLayerColors'],
      );
      return ThumbnailOverlay(
        gradientLayerColors: List.from(
          gradientLayerColorsJson.map(
            (e) => e.toString(),
          ),
        ),
        position: OverlayPosition.fromValue(
          getValue<String>(
            overlayRenderer,
            ['contentPosition'],
          ),
        ),
        playNavigationEndpoint: PlayNavigationEndpoint.fromJson(
          getValue(
            overlayRenderer,
            ['content', 'musicPlayButtonRenderer', 'playNavigationEndpoint'],
          ),
        ),
      );
    } catch (e) {
      log.error('Parse Overlay Error --> $e');
      rethrow;
    }
  }
}
