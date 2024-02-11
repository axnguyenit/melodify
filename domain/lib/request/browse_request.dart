import 'package:domain/domain.dart';

class BrowseRequest {
  final InnerTubeClient client;
  final Continuation continuation;
  final String innerTubeApiKey;

  BrowseRequest({
    required this.client,
    required this.continuation,
    required this.innerTubeApiKey,
  });

  Map<String, dynamic> toPayload() {
    return {
      'context': {
        'client': client.toJson(),
      }
    };
  }

  Map<String, dynamic> toQueries() {
    return {
      'ctoken': continuation.continuation,
      'continuation': continuation.continuation,
      'itct': continuation.itct,
      'key': innerTubeApiKey,
      'type': 'next',
    };
  }
}
