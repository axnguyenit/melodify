part of 'alert.dart';

enum AlertSeverity {
  info,
  success,
  warning,
  error;

  Color get color {
    return switch (this) {
      AlertSeverity.info => Palette.information,
      AlertSeverity.success => Palette.positive,
      AlertSeverity.warning => Palette.warning,
      AlertSeverity.error => Palette.negative,
    };
  }

  IconData get icon {
    return switch (this) {
      AlertSeverity.info => Icons.info_rounded,
      AlertSeverity.success => Icons.check_circle_rounded,
      AlertSeverity.warning => Icons.warning_rounded,
      AlertSeverity.error => Icons.error_rounded,
    };
  }
}

enum AlertVariant {
  simple,
  solid;

  Color get color {
    return switch (this) {
      AlertVariant.simple => Palette.information,
      AlertVariant.solid => Palette.positive,
    };
  }

  Color backgroundColor(Color color) {
    return switch (this) {
      AlertVariant.simple => color.withOpacity(0.16),
      AlertVariant.solid => color,
    };
  }

  Color textColor(BuildContext context, Color color) {
    return switch (this) {
      AlertVariant.simple => color,
      AlertVariant.solid => Colors.white,
    };
  }

  Color iconColor(Color color) {
    return switch (this) {
      AlertVariant.simple => color,
      AlertVariant.solid => Colors.white,
    };
  }
}
