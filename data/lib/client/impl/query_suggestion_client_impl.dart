import 'package:data/client/base_client.dart';
import 'package:data/client/client.dart';
import 'package:data/configs/config.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuerySuggestionClient)
class QuerySuggestionClientImpl extends BaseClient
    implements QuerySuggestionClient {
  QuerySuggestionClientImpl() : super(Config().querySuggestionUrl);

  @override
  Future<List<String>> getSuggestions(String query) async {
    final response = await get(
      '/complete/search',
      queries: {
        'q': query,
        'ds': 'yt',
        'client': 'firefox',
      },
    );
    return (response[1] as List).map((e) => e.toString()).toList();
  }
}
