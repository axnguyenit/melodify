import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class VideoDetails {
  final String id;
  final String title;
  final String channelId;
  final int viewCount;
  final int lengthSeconds;
  final String author;
  final String streamUrl;
  final DateTime expiredAt;
  final List<Thumbnail> thumbnails;

  const VideoDetails({
    required this.id,
    required this.title,
    required this.channelId,
    required this.viewCount,
    required this.lengthSeconds,
    required this.author,
    required this.streamUrl,
    required this.expiredAt,
    required this.thumbnails,
  });

  static DateTime _getExpiredAt(String url) {
    final matched = RegExp('expire=(.*?)&').firstMatch(url)!.group(1);
    // In fact, expired time after 6 hours
    if (matched == null) return DateTime.now().add(const Duration(hours: 5));
    return DateTime.fromMillisecondsSinceEpoch(int.parse(matched) * 1000);
  }

  factory VideoDetails.fromJson(JsonMap json) {
    // log.logMap(json);
    try {
      final videoDetails = json['videoDetails'];
      log.logMap(videoDetails);
      // final signatureCipher = getValue<String>(
      //     json, ['streamingData', 'formats', 0, 'signatureCipher']);
      // This way calling with web agent
      // final streamUrl = Uri.splitQueryString(signatureCipher)['url']!;
      final streamUrl =
          getValue<String>(json, ['streamingData', 'formats', 0, 'url']);
      final thumbnails =
          getValue<List>(videoDetails, ['thumbnail', 'thumbnails'], []);

      return VideoDetails(
        id: videoDetails['videoId'],
        title: videoDetails['title'],
        channelId: videoDetails['channelId'],
        viewCount: int.parse(videoDetails['viewCount']),
        lengthSeconds: int.parse(videoDetails['lengthSeconds']),
        author: videoDetails['author'],
        streamUrl: streamUrl,
        expiredAt: _getExpiredAt(streamUrl),
        thumbnails: List<Thumbnail>.from(
          thumbnails.map(
            (thumbnail) {
              return Thumbnail.fromJson(thumbnail);
            },
          ),
        ),
      );
    } catch (e) {
      log.error('Parse VideoDetails Error --> $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'channelId': channelId,
      'viewCount': viewCount,
      'lengthSeconds': lengthSeconds,
      'author': author,
      'streamUrl': streamUrl,
      'expiredAt': expiredAt.toIso8601String(),
      'thumbnails': thumbnails.map((thumbnail) => thumbnail.toJson()),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
