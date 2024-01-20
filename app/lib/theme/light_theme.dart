import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_theme.dart';
import 'palette.dart';

class LightTheme extends BaseTheme {
  @override
  ThemeData build(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      splashColor: Palette.grey50008,
      highlightColor: Palette.grey50012,
      focusColor: Palette.grey50024,
      disabledColor: Palette.grey50080,
      canvasColor: Palette.background.lightDefault,
      scaffoldBackgroundColor: Palette.background.lightDefault,
      shadowColor: Palette.grey500,
      dialogTheme: dialogTheme,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: primarySwatch,
        // TODO(kha): check color
        accentColor: Palette.primary500,
        cardColor: Palette.background.lightPaper,
        backgroundColor: Palette.background.lightDefault,
        errorColor: Palette.negative,
      ).copyWith(
        onBackground: Palette.grey50024, // disabled background
        tertiary: Palette.grey50032, // border color
        secondary: Palette.secondary500,
      ),
      textTheme: textTheme.apply(
        bodyColor: Palette.text.primaryLight,
        displayColor: Palette.text.primaryLight,
      ),
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: Palette.background.lightDefault,
        surfaceTintColor: Palette.background.lightDefault,
        foregroundColor: Palette.text.primaryLight,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0.0,
        margin: const EdgeInsets.all(0.0),
        color: Palette.background.lightPaper,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Palette.grey50024,
        thickness: 1.0,
      ),
      iconTheme: IconThemeData(color: Palette.grey50080),
      inputDecorationTheme: inputDecorationTheme,
      dropdownMenuTheme: dropdownMenuTheme,
      buttonTheme: const ButtonThemeData(
        alignedDropdown: true,
        padding: EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
