final _overlayPositionMap = {
  'MUSIC_ITEM_THUMBNAIL_OVERLAY_CONTENT_POSITION_BOTTOM_RIGHT':
      OverlayPosition.bottomRight,
  'MUSIC_ITEM_THUMBNAIL_OVERLAY_CONTENT_POSITION_CENTERED':
      OverlayPosition.center,
};

enum OverlayPosition {
  bottomRight,
  center;

  factory OverlayPosition.fromValue(String? value) {
    return _overlayPositionMap[value] ?? OverlayPosition.center;
  }
}
