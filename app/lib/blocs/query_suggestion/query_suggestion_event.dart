part of 'query_suggestion_bloc.dart';

sealed class QuerySuggestionEvent {}

final class QuerySuggestionSubmitted extends QuerySuggestionEvent {
  final String query;

  QuerySuggestionSubmitted({required this.query});
}
