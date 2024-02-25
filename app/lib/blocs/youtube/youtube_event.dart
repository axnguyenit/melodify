part of 'youtube_bloc.dart';

@immutable
sealed class YoutubeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class YoutubeConfigured extends YoutubeEvent {
  final YTConfig ytConfig;

  YoutubeConfigured({required this.ytConfig});
}
