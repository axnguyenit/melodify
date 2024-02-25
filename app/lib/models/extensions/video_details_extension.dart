import 'package:audio_service/audio_service.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

extension VideoDetailsExtension on VideoDetails {
  MediaItem toMediaItem() {
    return MediaItem(
      id: id,
      title: title,
      artist: author,
      duration: Duration(seconds: lengthSeconds),
      artUri: Uri.parse(thumbnails.last.url),
      extras: {
        'url': streamUrl,
        'expire_at': expiredAt.secondsSinceEpoch,
      },
    );
  }
}
