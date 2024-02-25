import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class ThumbnailCornerOverlay {
  final ThumbnailCrop thumbnailCrop;
  final List<Thumbnail> thumbnails;

  ThumbnailCornerOverlay({
    required this.thumbnailCrop,
    required this.thumbnails,
  });

  factory ThumbnailCornerOverlay.fromJson(Map<String, dynamic> json) {
    try {
      final renderer = getValue(json, ['musicThumbnailRenderer']);
      final thumbnails = getValue<List>(
        renderer,
        [
          'thumbnail',
          'thumbnails',
        ],
        [],
      );

      return ThumbnailCornerOverlay(
        thumbnailCrop: ThumbnailCrop.fromValue(getValue(renderer, [
          'thumbnailCrop',
        ])),
        thumbnails: List.from(
          thumbnails.map(
            (thumbnail) {
              return Thumbnail.fromJson(thumbnail);
            },
          ),
        ),
      );
    } catch (e) {
      log.error(e);
      rethrow;
    }
  }
}
