abstract class QuerySuggestionRepository {
  Future<List<String>> getSuggestions(String query);
}
