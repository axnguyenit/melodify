part of 'youtube_bloc.dart';

@immutable
sealed class YoutubeState extends Equatable {
  final YTConfig? ytConfig;

  const YoutubeState({this.ytConfig});

  @override
  List<Object?> get props => [];
}

final class YoutubeInitial extends YoutubeState {}

final class YoutubeConfigureSuccess extends YoutubeState {
  const YoutubeConfigureSuccess({
    required YTConfig ytConfig,
  }) : super(ytConfig: ytConfig);
}
