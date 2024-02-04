import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/overrides/overrides.dart';

import 'palette.dart';
import 'theme_text.dart';

abstract class BaseTheme {
  ColorScheme get colorScheme => const ColorScheme.light();

  AppBarTheme get appBarTheme => const AppBarTheme(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        toolbarTextStyle: TextStyle(
          // fontFamily: fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      );

  String get fontFamily => 'Public Sans';

  TextTheme get textTheme => ThemeText.getDefaultTextTheme();

  MaterialColor get primarySwatch => MaterialColor(
        Palette.primary500.value,
        const <int, Color>{
          100: Palette.primary100,
          200: Palette.primary200,
          300: Palette.primary300,
          400: Palette.primary400,
          500: Palette.primary500,
          600: Palette.primary600,
          700: Palette.primary700,
          800: Palette.primary800,
          900: Palette.primary900,
        },
      );

  DialogTheme get dialogTheme => DialogTheme(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

  InputDecorationTheme get inputDecorationTheme =>
      XInputDecoration.inputDecoration(textTheme);

  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        elevation: 0.0,
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        type: BottomNavigationBarType.fixed,
      );

  DropdownMenuThemeData get dropdownMenuTheme => DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        inputDecorationTheme: inputDecorationTheme,
        menuStyle: MenuStyle(
          elevation: MaterialStateProperty.all<double>(5.0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.formFieldBorderRadius,
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(8.0),
          ),
          // backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
        ),
      );

  ThemeData build(BuildContext context);
}
