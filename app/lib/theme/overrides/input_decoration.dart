import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';

class XInputDecoration {
  static InputDecorationTheme inputDecoration(TextTheme textTheme) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.grey50032),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.grey50032),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.grey50080),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Palette.primary500),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Palette.negative),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Palette.primary500),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
      filled: true,
      isDense: true,
      fillColor: MaterialStateColor.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Palette.grey50024;
          }

          // if (states.contains(MaterialState.error)) {
          //   return Palette.negative.withOpacity(0.1);
          // }

          return Colors.transparent;
        },
      ),
      contentPadding: AppConstants.inputContentPadding,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          Color color = Palette.grey50080;
          if (states.contains(MaterialState.error)) {
            color = Palette.negative;
          }

          return textTheme.labelLarge!.copyWith(color: color);
        },
      ),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          Color color = Palette.grey50080;
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.selected)) {
            color = Palette.primary500;
          } else if (states.contains(MaterialState.error)) {
            color = Palette.negative;
          }

          return textTheme.labelLarge!.copyWith(color: color);
        },
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: Palette.grey50080,
      ),
      // prefixStyle: textTheme.bodySmall?.copyWith(
      //   color: Palette.text.primaryLight,
      // ),
      errorStyle: textTheme.labelSmall?.copyWith(height: 0.3),
      // prefixIconColor:
    );
  }
}
