final _yTMusicSearchResultItemTypeMap = {
  'song': YTMSectionItemType.song,
  'video': YTMSectionItemType.video,
  'album': YTMSectionItemType.album,
  'artist': YTMSectionItemType.artist,
  'single': YTMSectionItemType.single,
  'playlist': YTMSectionItemType.playlist,
  'station': YTMSectionItemType.station,
  'podcast': YTMSectionItemType.podcast,
  'profile': YTMSectionItemType.profile,
};

enum YTMSectionItemType {
  song,
  video,
  album,
  artist,
  single,
  playlist,
  station,
  podcast,
  profile;

  factory YTMSectionItemType.fromValue(String? value) {
    return _yTMusicSearchResultItemTypeMap[value] ?? YTMSectionItemType.song;
  }

  bool get isSong => this == YTMSectionItemType.song;

  bool get isVideo => this == YTMSectionItemType.video;

  bool get isAlbum => this == YTMSectionItemType.album;

  bool get isArtist => this == YTMSectionItemType.artist;

  bool get isSingle => this == YTMSectionItemType.single;

  bool get isPlaylist => this == YTMSectionItemType.playlist;

  bool get isStation => this == YTMSectionItemType.station;

  bool get isPodcast => this == YTMSectionItemType.podcast;

  bool get isProfile => this == YTMSectionItemType.profile;
}
