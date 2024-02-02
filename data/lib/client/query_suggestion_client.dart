abstract class QuerySuggestionClient {
  Future<List<String>> getSuggestions(String query);
}
