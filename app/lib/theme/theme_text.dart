import 'package:flutter/material.dart';

class ThemeText {
  static TextTheme getDefaultTextTheme() => const TextTheme(
        displayLarge: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700),

        // ─────────── HEADLINE ─────────── //
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),

        // ─────────── TITLE ─────────── //
        /**
         * AppBar title
         */
        titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),

        // ─────────── LABEL ─────────── //
        /**
         * Button
         *
         */
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),

        // ─────────── BODY ─────────── //
        /**
         * Placeholder
         *
         */
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),

        /**
         *
         */
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),

        /**
         * Label TextField
         * Supporting text
         */
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      );
}
