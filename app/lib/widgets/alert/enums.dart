part of 'alert.dart';

enum AlertSeverity {
  info,
  success,
  warning,
  error;

  Color get color {
    switch (this) {
      case AlertSeverity.info:
        return Palette.information;
      case AlertSeverity.success:
        return Palette.positive;
      case AlertSeverity.warning:
        return Palette.warning;
      case AlertSeverity.error:
        return Palette.negative;
    }
  }

  IconData get icon {
    switch (this) {
      case AlertSeverity.info:
        return Icons.info_rounded;
      case AlertSeverity.success:
        return Icons.check_circle_rounded;
      case AlertSeverity.warning:
        return Icons.warning_rounded;
      case AlertSeverity.error:
        return Icons.error_rounded;
    }
  }
}

enum AlertVariant {
  simple,
  solid;

  Color get color {
    switch (this) {
      case AlertVariant.simple:
        return Palette.information;
      case AlertVariant.solid:
        return Palette.positive;
    }
  }

  Color backgroundColor(Color color) {
    switch (this) {
      case AlertVariant.simple:
        return color.withOpacity(0.16);
      case AlertVariant.solid:
        return color;
    }
  }

  Color textColor(BuildContext context, Color color) {
    switch (this) {
      case AlertVariant.simple:
        return color;
      case AlertVariant.solid:
        return Colors.white;
    }
  }

  Color iconColor(Color color) {
    switch (this) {
      case AlertVariant.simple:
        return color;
      case AlertVariant.solid:
        return Colors.white;
    }
  }
}
