part of 'query_suggestion_bloc.dart';

sealed class QuerySuggestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class QuerySuggestionInitial extends QuerySuggestionState {}

final class QuerySuggestionSubmitInProgress extends QuerySuggestionState {}

final class QuerySuggestionSubmitSuccess extends QuerySuggestionState {
  final List<String> suggestions;

  QuerySuggestionSubmitSuccess({required this.suggestions});
}

final class QuerySuggestionSubmitFailure extends QuerySuggestionState {}
