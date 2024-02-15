final _aspectRatioMap = {
  'MUSIC_TWO_ROW_ITEM_THUMBNAIL_ASPECT_RATIO_RECTANGLE_16_9':
      AspectRatioEnum.portrait,
  'MUSIC_TWO_ROW_ITEM_THUMBNAIL_ASPECT_RATIO_SQUARE': AspectRatioEnum.square,
};

enum AspectRatioEnum {
  portrait(16 / 9),
  landscape(9 / 16),
  square(1 / 1);

  final double value;

  const AspectRatioEnum(this.value);

  factory AspectRatioEnum.fromValue(String? value) {
    return _aspectRatioMap[value] ?? AspectRatioEnum.square;
  }

  bool get isSquare => this == AspectRatioEnum.square;
}
