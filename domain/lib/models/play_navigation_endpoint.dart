import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class PlayNavigationEndpoint {
  final String? videoId;
  final String? playlistId;
  final EndpointType endpointType;
  final String clickTrackingParams;

  PlayNavigationEndpoint({
    required this.videoId,
    required this.playlistId,
    required this.endpointType,
    required this.clickTrackingParams,
  });

  factory PlayNavigationEndpoint.fromJson(Map<String, dynamic> json) {
    try {
      String? videoId;
      String? playlistId;
      EndpointType endpointType = EndpointType.watchEndpoint;

      if (json.containsKey('watchEndpoint')) {
        final watchEndpoint = json['watchEndpoint'];
        videoId = watchEndpoint['videoId'];
        playlistId = watchEndpoint['playlistId'];
      } else {
        // if (json.containsKey('watchPlaylistEndpoint'))
        final watchPlaylistEndpoint = json['watchPlaylistEndpoint'];
        playlistId = watchPlaylistEndpoint['playlistId'];
        endpointType = EndpointType.watchPlaylistEndpoint;
      }

      return PlayNavigationEndpoint(
        videoId: videoId,
        playlistId: playlistId,
        endpointType: endpointType,
        clickTrackingParams: getValue(json, ['clickTrackingParams']),
      );
    } catch (e) {
      log.error('Parse PlayNavigationEndpoint Error --> $e');
      rethrow;
    }
  }
}
