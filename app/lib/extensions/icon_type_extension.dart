import 'package:domain/domain.dart';
import 'package:melodify/constants/constants.dart';

extension IconTypeExtension on IconType {
  String get iconPath {
    return switch (this) {
      IconType.mix => AppIcons.rfidOutline,
      IconType.queuePlayNext => AppIcons.playlist,
      IconType.addToRemoteQueue => AppIcons.playlist2,
      IconType.libraryAdd => AppIcons.libraryAdd,
      IconType.addToPlaylist => AppIcons.playlistAdd,
      IconType.album => AppIcons.album,
      IconType.artist => AppIcons.userMusicOutline,
      IconType.share => AppIcons.shareOutline,
    };
  }
}
