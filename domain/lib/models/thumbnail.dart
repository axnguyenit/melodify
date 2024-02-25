import 'package:core/core.dart';

class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    try {
      return Thumbnail(
        url: json['url'] as String,
        width: json['width'] as int,
        height: json['height'] as int,
      );
    } catch (e) {
      log.error('Parse Thumbnail Error --> $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
