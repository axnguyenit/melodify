part of 'video_details_bloc.dart';

@immutable
sealed class VideoDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ════════════════════════════════════════════
final class VideoDetailsLoaded extends VideoDetailsEvent {
  final String videoId;
  final String? playlistId;

  VideoDetailsLoaded({
    required this.videoId,
    required this.playlistId,
  });
}
