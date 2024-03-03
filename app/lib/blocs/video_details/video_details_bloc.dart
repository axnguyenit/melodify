import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';

part 'video_details_event.dart';
part 'video_details_state.dart';

@LazySingleton()
class VideoDetailsBloc extends BaseBloc<VideoDetailsEvent, VideoDetailsState>
    with YoutubeData {
  final YoutubeMusicService _ymService;
  VideoDetailsBloc(YoutubeMusicService ymService)
      : _ymService = ymService,
        super(Keys.Blocs.videoDetails, VideoDetailsInitial()) {
    on<VideoDetailsLoaded>(_onVideoDetailsLoaded);
  }

  Future<void> _onVideoDetailsLoaded(
    VideoDetailsLoaded event,
    Emitter<VideoDetailsState> emit,
  ) async {
    try {
      emit(VideoDetailsLoadInProgress());
      final videoDetails = await _ymService.player(
        request: GetPlayerRequest(
          videoId: event.videoId,
          playlistId: event.playlistId,
          client: ytConfig.innerTubeClient,
        ),
      );

      log.warning('videoDetails --> ${videoDetails.streamUrl}');
      emit(VideoDetailsLoadSuccess(videoDetails: videoDetails));
    } catch (e) {
      log.error(e);
      emit(VideoDetailsLoadFailure());
    }
  }
}
