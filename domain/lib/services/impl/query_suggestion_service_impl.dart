import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

@Injectable(as: QuerySuggestionService)
class QuerySuggestionServiceImpl implements QuerySuggestionService {
  final QuerySuggestionRepository _querySuggestionRepository;
  final _youtubeExplode = YoutubeExplode();

  QuerySuggestionServiceImpl(this._querySuggestionRepository);

  @override
  Future<List<String>> getSuggestions(String query) {
    // return _querySuggestionRepository.getSuggestions(query);
    return _youtubeExplode.search.getQuerySuggestions(query);
  }
}
