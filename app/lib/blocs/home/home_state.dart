part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  final YTConfig? ytConfig;
  final Continuation? continuation;
  final List<MusicCarouselShelf> musicCarouselShelfList;

  const HomeState({
    this.ytConfig,
    this.continuation,
    this.musicCarouselShelfList = const [],
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

final class HomeInitial extends HomeState {}

// ════════════════════════════════════════════

final class HomeLoadInProgress extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({
    required super.ytConfig,
    required super.continuation,
    required super.musicCarouselShelfList,
  });
}

final class HomeLoadFailure extends HomeState {}

// ════════════════════════════════════════════

final class HomeBrowseInProgress extends HomeState {
  const HomeBrowseInProgress({
    required super.ytConfig,
    required super.continuation,
    required super.musicCarouselShelfList,
  });
}

final class HomeBrowseSuccess extends HomeState {
  const HomeBrowseSuccess({
    required super.ytConfig,
    required super.continuation,
    required super.musicCarouselShelfList,
  });
}

final class HomeBrowseFailure extends HomeState {
  const HomeBrowseFailure({
    required super.ytConfig,
    required super.continuation,
    required super.musicCarouselShelfList,
  });
}
