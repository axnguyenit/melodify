import 'package:core/core.dart';

class YTMSectionItemThumbnail {
  final String url;
  final int width;
  final int height;

  YTMSectionItemThumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory YTMSectionItemThumbnail.fromJson(Map<String, dynamic> json) {
    try {
      return YTMSectionItemThumbnail(
        url: json['url'] as String,
        width: json['width'] as int,
        height: json['height'] as int,
      );
    } catch (e) {
      log.error('Parse Thumbnail Error --> $e');
      rethrow;
    }
  }
}
