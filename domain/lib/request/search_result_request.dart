import 'package:domain/domain.dart';

class SearchResultRequest {
  final String query;
  final InnerTubeClient client;
  final String innerTubeApiKey;

  SearchResultRequest({
    required this.query,
    required this.client,
    required this.innerTubeApiKey,
  });

  Map<String, dynamic> toPayload() {
    return {
      'query': query,
      'context': {
        'client': client.toJson(),
      }
    };
  }

  Map<String, dynamic> toQueries() {
    return {
      'key': innerTubeApiKey,
    };
  }
}
