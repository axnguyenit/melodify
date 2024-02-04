import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_theme.dart';
import 'palette.dart';

class DarkTheme extends BaseTheme {
  @override
  ThemeData build(BuildContext context) {
    return ThemeData(
      // fontFamily: fontFamily,
      splashColor: Palette.grey50008,
      highlightColor: Palette.grey50012,
      focusColor: Palette.grey50024,
      disabledColor: Palette.grey50080,
      canvasColor: Palette.background.darkDefault,
      // menu dropdown background
      scaffoldBackgroundColor: Palette.background.darkDefault,
      shadowColor: Palette.black,
      dialogTheme: dialogTheme,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: primarySwatch,
        // TODO(kha): check color
        accentColor: Palette.primary500,
        cardColor: Palette.background.darkPaper,
        backgroundColor: Palette.background.darkDefault,
        errorColor: Palette.negative,
      ).copyWith(
        onBackground: Palette.grey50024, // disabled background
        tertiary: Palette.grey50032, // border color
        secondary: Palette.secondary500,
      ),
      textTheme: textTheme.apply(
        bodyColor: Palette.text.primaryDark,
        displayColor: Palette.text.primaryDark,
      ),
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: Palette.background.darkDefault,
        surfaceTintColor: Palette.background.darkDefault,
        foregroundColor: Palette.text.primaryDark,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0.0,
        margin: const EdgeInsets.all(0.0),
        color: Palette.background.darkPaper,
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
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(22),
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
      ),
      bottomNavigationBarTheme: bottomNavigationBarThemeData.copyWith(
        selectedItemColor: Palette.text.primaryDark,
        unselectedItemColor: Palette.text.primaryDark,
        backgroundColor: Palette.background.darkPaper,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Palette.background.darkPaper,
        surfaceTintColor: Palette.background.darkPaper,
      ),
      chipTheme: const ChipThemeData(
        side: BorderSide(
          color: Color(0xFF2E2E2E),
          width: 1,
        ),
        backgroundColor: Color(0xFF1A1A1A),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: Palette.background.darkPaper,
        shadowColor: Colors.transparent,
        surfaceTintColor: Palette.black.withAlpha(100),
        modalBarrierColor: Palette.black.withAlpha(100),
        shape: const RoundedRectangleBorder(),
      ),
    );
  }
}

/// card --> 181818
/// chip background --> 1A1A1A
/// chip border --> 2E2E2E