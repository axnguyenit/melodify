import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'loading_event.dart';
part 'loading_state.dart';

@LazySingleton()
class LoadingBloc extends BaseBloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(Keys.Blocs.loading, LoadingInitial()) {
    on<LoadingStated>(_onLoadingStated);
    on<LoadingStopped>(_onLoadingStopped);
  }

  Future<void> _onLoadingStated(
    LoadingStated event,
    Emitter<LoadingState> emit,
  ) async {
    if (state is LoadingStartSuccess) return;
    emit(LoadingStartSuccess());
  }

  Future<void> _onLoadingStopped(
    LoadingStopped event,
    Emitter<LoadingState> emit,
  ) async {
    if (state is LoadingStopSuccess) return;
    emit(LoadingStopSuccess());
  }
}
