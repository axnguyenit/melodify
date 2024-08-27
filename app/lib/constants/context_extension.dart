import 'package:flutter/material.dart';
import 'package:melodify/theme/palette.dart';

extension ContextExtension on BuildContext {
  void hideKeyboardIfNeeded() => FocusScope.of(this).unfocus();

  ThemeData get theme => Theme.of(this);

  TextStyle? get displayLarge => theme.textTheme.displayLarge;

  TextStyle? get displayMedium => theme.textTheme.displayMedium;

  TextStyle? get displaySmall => theme.textTheme.displaySmall;

  TextStyle? get headlineLarge => theme.textTheme.headlineLarge;

  TextStyle? get headlineMedium => theme.textTheme.headlineMedium;

  TextStyle? get headlineSmall => theme.textTheme.headlineSmall;

  TextStyle? get titleLarge => theme.textTheme.titleLarge;

  TextStyle? get titleMedium => theme.textTheme.titleMedium;

  TextStyle? get titleSmall => theme.textTheme.titleSmall;

  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;

  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;

  TextStyle? get bodySmall => theme.textTheme.bodySmall;

  TextStyle? get labelLarge => theme.textTheme.labelLarge;

  TextStyle? get labelMedium => theme.textTheme.labelMedium;

  TextStyle? get labelSmall => theme.textTheme.labelSmall;

  // ─────────── COLORS ─────────── //
  Color get primaryColor => theme.colorScheme.primary;

  Color get primaryColorDark => theme.colorScheme.primaryContainer;

  Color get secondaryColor => theme.colorScheme.secondary;

  Color get errorColor => theme.colorScheme.error;

  Color get shimmerBaseColor => theme.colorScheme.primary;

  Color get shimmerHighlightColor => theme.colorScheme.primary;

  Color get dividerColor => theme.dividerColor;

  Color get onPrimary => theme.colorScheme.onPrimary;

  Color get onSecondary => theme.colorScheme.onSecondary;

  Color get cardColor => theme.cardColor;

  Color get unselectedWidgetColor => theme.unselectedWidgetColor;

  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  Color get backgroundColor => theme.colorScheme.background;

  Color get disabledColor => theme.disabledColor;

  Color get borderColor => theme.colorScheme.tertiary;

  Color get disabledBackgroundColor => theme.colorScheme.onBackground;

  Color? get textColor => theme.textTheme.labelLarge?.color;

  Color? get iconColor => theme.iconTheme.color;

  Color get shadowColor => theme.shadowColor;

  Color get splashColor => theme.splashColor;

  Color get highlightColor => theme.highlightColor;

  Color get focusColor => theme.focusColor;

  // ─────────── THEME DATA ─────────── //
  InputDecorationTheme get inputDecorationTheme => theme.inputDecorationTheme;

  //
  bool get isLightMode => theme.brightness == Brightness.light;

  Color get chipSelectedBackground => isLightMode
      ? Palette.black.withAlpha((0.08 * 255).toInt())
      : Palette.white;

  Color get chipBackground => isLightMode
      ? Palette.black.withAlpha((0.08 * 255).toInt())
      : Palette.white.withOpacity(0.08);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;
}
