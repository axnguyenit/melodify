// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class _Background {
  // ─────────── LIGHT MODE ─────────── //
  final Color lightDefault = const Color(0xFFFFFFFF);
  final Color lightPaper = const Color(0xFFFFFFFF);

  // ─────────── DARK MODE ─────────── //
  final Color darkDefault = const Color(0xFF161C24);
  final Color darkPaper = const Color(0xFF212B36); // card
}

class _TextColor {
  // ─────────── LIGHT MODE ─────────── //
  final Color primaryLight = const Color(0xFF212B36);
  final Color secondaryLight = const Color(0xFF637381);
  final Color disabledLight = const Color(0xFF919EAB);

  // ─────────── DARK MODE ─────────── //
  final Color primaryDark = const Color(0xFFFFFFFF);
  final Color secondaryDark = const Color(0xFF919EAB);
  final Color disabledDark = const Color(0xFFFFFFFF);
}

class Palette {
  Palette._();

  static _TextColor get text => _TextColor();

  static _Background get background => _Background();

  // ─────────── COMMON COLORS ─────────── //
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ─────────── ACTION BASE COLORS ─────────── //
  static const Color negative = Color(0xFFFF4842);
  static const Color positive = Color(0xFF33B76B);
  static const Color warning = Color(0xFFFFC107);
  static const Color information = Color(0xFF1890FF);

  // ─────────── PRIMARY COLORS ─────────── //
  static const Color primary100 = Color(0xFFDADBFF);
  static const Color primary200 = Color(0xFFB5B7FF);
  static const Color primary300 = Color(0xFF9093FF);
  static const Color primary400 = Color(0xFF7578FF);
  static const Color primary500 = Color(0xFF474BFF);
  static const Color primary600 = Color(0xFF3337DB);
  static const Color primary700 = Color(0xFF2326B7);
  static const Color primary800 = Color(0xFF161893);
  static const Color primary900 = Color(0xFF0D0F7A);

  // ─────────── SECONDARY COLORS ─────────── //
  static const Color secondary500 = Color(0xFF00AB55);

  // ─────────── GREY COLORS ─────────── //
  static const Color grey100 = Color(0xFFF9FAFB);
  static const Color grey200 = Color(0xFFF4F6F8);
  static const Color grey300 = Color(0xFFDFE3E8);
  static const Color grey400 = Color(0xFFC4CDD5);
  static const Color grey500 = Color(0xFF919EAB);
  static const Color grey600 = Color(0xFF637381); // Icon ColorØ
  static const Color grey700 = Color(0xFF454F5B);
  static const Color grey800 = Color(0xFF212B36);
  static const Color grey900 = Color(0xFF161C24);
  static final Color grey50008 = grey500.withOpacity(0.08);
  static final Color grey50012 = grey500.withOpacity(0.12);
  static final Color grey50016 = grey500.withOpacity(0.16);
  static final Color grey50020 = grey500.withOpacity(0.2);
  static final Color grey50024 = grey500.withOpacity(0.24);
  static final Color grey50032 = grey500.withOpacity(0.32);
  static final Color grey50048 = grey500.withOpacity(0.48);
  static final Color grey50056 = grey500.withOpacity(0.56);
  static final Color grey50080 = grey500.withOpacity(0.8);
}
