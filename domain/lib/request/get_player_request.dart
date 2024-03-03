import 'package:domain/domain.dart';

class GetPlayerRequest {
  final String? videoId;
  final String? playlistId;
  final InnerTubeClient client;

  GetPlayerRequest({
    required this.videoId,
    required this.playlistId,
    required this.client,
  });

  // TODO(ax): Update hl, gl payload data
  Map<String, dynamic> toPayload() {
    return {
      if (videoId != null) 'videoId': videoId,
      if (playlistId != null) 'playlistId': playlistId,
      'context': {
        'client': client.toJson(),
      },
    };
  }
}
