import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class PhoneField extends StatefulWidget {
  final bool enabled;
  final bool autocorrect;
  final bool enabledClear;

  final String? label;
  final String? placeholder;
  final String? initialValue;

  final EdgeInsets? padding;

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  final void Function(String? value)? onValid;
  final void Function(String? value)? onFieldSubmitted;

  final List<ValidationRule> validationRules;
  final AutovalidateMode? autoValidateMode;

  final String phoneCode;
  final VoidCallback? onPhoneCodePressed;

  // ════════════════════════════════════════════

  const PhoneField({
    super.key,
    this.enabled = true,
    this.autocorrect = true,
    this.enabledClear = false,
    this.label,
    this.placeholder,
    this.initialValue,
    this.padding,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.onValid,
    this.onFieldSubmitted,
    this.validationRules = const [],
    this.autoValidateMode,
    required this.phoneCode,
    this.onPhoneCodePressed,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return XTextField(
      focusNode: widget.focusNode,
      enabledClear: widget.enabledClear,
      enabled: widget.enabled,
      autocorrect: widget.autocorrect,
      label: widget.label,
      placeholder: widget.placeholder,
      enabledBorder: widget.enabledBorder,
      disabledBorder: widget.disabledBorder,
      focusedBorder: widget.focusedBorder,
      initialValue: widget.initialValue,
      keyboardType: TextInputType.phone,
      padding: widget.padding,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      onValid: widget.onValid,
      onFieldSubmitted: widget.onFieldSubmitted,
      validationRules: widget.validationRules,
      autoValidateMode: widget.autoValidateMode,
      prefixIcon: _prefixIcon,
    );
  }

  Widget get _prefixIcon {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWellButton(
            width: AppConstants.formFieldHeight * 1.5,
            height: AppConstants.formFieldHeight,
            onPressed: widget.onPhoneCodePressed,
            child: Center(
              child: Text('+${widget.phoneCode}'),
            ),
          ),
          const VerticalDivider(width: 1),
          SizedBox(width: AppConstants.inputContentPadding.left),
        ],
      ),
    );
  }
}
