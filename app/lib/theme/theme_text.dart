import 'package:flutter/material.dart';

class ThemeText {
  static TextTheme getDefaultTextTheme() => const TextTheme(
        displayLarge: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700),

        // ─────────── HEADLINE ─────────── //
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),

        // ─────────── TITLE ─────────── //
        /**
         * AppBar title
         */
        titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        /**
         * Tab
         */
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),

        // ─────────── LABEL ─────────── //
        /**
         * Button
         * Chip
         */
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        /**
         * BottomBar label
         */
        labelMedium: TextStyle(
          fontSize: 12.0,
          height: 12 / 16,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 11.0,
          height: 11 / 16,
          fontWeight: FontWeight.w500,
        ),

        // ─────────── BODY ─────────── //
        /**
         * Placeholder
         * Title - ListTile
         */
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),

        /**
         * Subtitle - ListTile
         */
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),

        /**
         * Label TextField
         * Supporting text
         */
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      );
}
