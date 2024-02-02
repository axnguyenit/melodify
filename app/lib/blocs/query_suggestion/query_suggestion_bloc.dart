import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'query_suggestion_event.dart';
part 'query_suggestion_state.dart';

@Injectable()
class QuerySuggestionBloc
    extends BaseBloc<QuerySuggestionEvent, QuerySuggestionState> {
  final QuerySuggestionService _querySuggestionService;

  QuerySuggestionBloc(this._querySuggestionService)
      : super(Keys.Blocs.querySuggestion, QuerySuggestionInitial()) {
    on<QuerySuggestionSubmitted>(_onQuerySuggestionSubmitted);
  }

  Future<void> _onQuerySuggestionSubmitted(
    QuerySuggestionSubmitted event,
    Emitter<QuerySuggestionState> emit,
  ) async {
    try {
      emit(QuerySuggestionSubmitInProgress());
      final suggestions =
          await _querySuggestionService.getSuggestions(event.query);
      emit(QuerySuggestionSubmitSuccess(suggestions: suggestions));
    } catch (e) {
      emit(QuerySuggestionSubmitFailure());
      log.error(e);
    }
  }
}
