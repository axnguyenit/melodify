part of 'helper_text.dart';

enum HelperTextStatus {
  information,
  positive,
  warning,
  negative;

  Color get color {
    switch (this) {
      case HelperTextStatus.information:
        return Palette.information;
      case HelperTextStatus.positive:
        return Palette.positive;
      case HelperTextStatus.warning:
        return Palette.warning;
      case HelperTextStatus.negative:
        return Palette.negative;
    }
  }
}
