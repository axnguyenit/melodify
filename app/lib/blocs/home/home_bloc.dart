import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';

part 'home_event.dart';
part 'home_state.dart';

@LazySingleton()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> with AppLoading {
  final YoutubeMusicService _ytmService;
  HomeBloc(this._ytmService) : super(Keys.Blocs.home, HomeInitial()) {
    on<HomeLoaded>(_onHomeLoaded);
    on<HomeBrowsed>(_onHomeBrowsed);
  }

  Future<void> _onHomeLoaded(
    HomeLoaded event,
    Emitter<HomeState> emit,
  ) async {
    try {
      showLoading();
      emit(HomeLoadInProgress());
      final HomeData(:content, :ytConfig) =
          await _ytmService.getHome(localeCode: 'en');
      final Content(:continuation, :musicCarouselShelfList) =
          await _ytmService.browse(
        BrowseRequest(
          client: ytConfig.innerTubeClient,
          continuation: content.continuation!,
          innerTubeApiKey: ytConfig.innerTubeApiKey,
        ),
      );

      emit(HomeLoadSuccess(
        ytConfig: ytConfig,
        continuation: continuation,
        musicCarouselShelfList: [
          ...content.musicCarouselShelfList,
          ...musicCarouselShelfList,
        ],
      ));
    } catch (e) {
      log.error(e);
      emit(HomeLoadFailure());
    } finally {
      hideLoading();
    }
  }

  Future<void> _onHomeBrowsed(
    HomeBrowsed event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeBrowseInProgress(
        ytConfig: state.ytConfig,
        continuation: state.continuation,
        musicCarouselShelfList: state.musicCarouselShelfList,
      ));
      final Content(:continuation, :musicCarouselShelfList) =
          await _ytmService.browse(BrowseRequest(
        client: state.ytConfig!.innerTubeClient,
        continuation: state.continuation!,
        innerTubeApiKey: state.ytConfig!.innerTubeApiKey,
      ));
      emit(HomeBrowseSuccess(
        ytConfig: state.ytConfig,
        continuation: continuation,
        musicCarouselShelfList: [
          ...state.musicCarouselShelfList,
          ...musicCarouselShelfList
        ],
      ));
    } catch (e) {
      log.error(e);
      emit(HomeBrowseFailure(
        ytConfig: state.ytConfig,
        continuation: state.continuation,
        musicCarouselShelfList: state.musicCarouselShelfList,
      ));
    }
  }
}
