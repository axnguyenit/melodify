import 'package:data/client/client.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: QuerySuggestionRepository)
class QuerySuggestionRepositoryImpl implements QuerySuggestionRepository {
  final QuerySuggestionClient _QuerySuggestionClient;

  QuerySuggestionRepositoryImpl(this._QuerySuggestionClient);

  @override
  Future<List<String>> getSuggestions(String query) {
    return _QuerySuggestionClient.getSuggestions(query);
  }
}
