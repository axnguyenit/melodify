import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

void showCountryPickerDrawer(
  BuildContext context, {
  required void Function(Country) onSelected,
  String placeholder = 'Choose your county',
}) {
  showCountryPicker(
    context: context,
    showPhoneCode: true,
    // favorite: ['VN'],
    countryListTheme: CountryListThemeData(
      flagSize: 22,
      bottomSheetHeight: 600,
      borderRadius: BorderRadius.circular(20),
      backgroundColor: context.backgroundColor,
      textStyle: context.bodyMedium,
      inputDecoration: InputDecoration(
        hintStyle: context.bodyMedium?.copyWith(color: context.disabledColor),
        labelStyle: context.bodyMedium,
        prefixIcon: Icon(
          Icons.language_rounded,
          color: context.iconColor,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: AppConstants.formFieldHeight,
          maxWidth: AppConstants.formFieldHeight,
        ),
        hintText: placeholder,
        enabledBorder: context.inputDecorationTheme.enabledBorder,
        focusedBorder: context.inputDecorationTheme.focusedBorder,
      ),
    ),
    onSelect: onSelected,
  );
}
