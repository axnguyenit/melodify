part of 'video_details_bloc.dart';

@immutable
sealed class VideoDetailsState extends Equatable {
  final VideoDetails? videoDetails;

  const VideoDetailsState({this.videoDetails});

  @override
  List<Object?> get props => [];
}

final class VideoDetailsInitial extends VideoDetailsState {}

// ════════════════════════════════════════════
final class VideoDetailsLoadInProgress extends VideoDetailsState {}

final class VideoDetailsLoadSuccess extends VideoDetailsState {
  const VideoDetailsLoadSuccess({required super.videoDetails});
}

final class VideoDetailsLoadFailure extends VideoDetailsState {}
