final _thumbnailCropMap = {
  'MUSIC_THUMBNAIL_CROP_CIRCLE': ThumbnailCrop.circle,
};

enum ThumbnailCrop {
  circle;

  factory ThumbnailCrop.fromValue(String? value) {
    return _thumbnailCropMap[value] ?? ThumbnailCrop.circle;
  }
}
