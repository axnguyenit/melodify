import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

@LazySingleton()
class YoutubeBloc extends BaseBloc<YoutubeEvent, YoutubeState> {
  YoutubeBloc() : super(Keys.Blocs.youtube, YoutubeInitial()) {
    on<YoutubeConfigured>(_onYoutubeConfigured);
  }

  Future<void> _onYoutubeConfigured(
    YoutubeConfigured event,
    Emitter<YoutubeState> emit,
  ) async {
    emit(YoutubeConfigureSuccess(ytConfig: event.ytConfig));
  }
}
