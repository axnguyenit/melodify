final _iconTypeMap = {
  'MIX': IconType.mix,
  'QUEUE_PLAY_NEXT': IconType.queuePlayNext,
  'ADD_TO_REMOTE_QUEUE': IconType.addToRemoteQueue,
  'LIBRARY_ADD': IconType.libraryAdd,
  'ADD_TO_PLAYLIST': IconType.addToPlaylist,
  'ALBUM': IconType.album,
  'ARTIST': IconType.artist,
  'SHARE': IconType.share,
};

enum IconType {
  mix,
  queuePlayNext,
  addToRemoteQueue,
  libraryAdd,
  addToPlaylist,
  album,
  artist,
  share;

  factory IconType.fromValue(String? value) {
    return _iconTypeMap[value] ?? IconType.album;
  }
}
