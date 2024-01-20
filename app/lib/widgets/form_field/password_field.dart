import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class PasswordField extends StatefulWidget {
  final bool enabled;
  final bool autocorrect;
  final bool enabledClear;

  final String? label;
  final String placeholder;
  final Widget? prefixIcon;
  final String initialValue;

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

  // ────────────────────────────────────────────

  const PasswordField({
    super.key,
    this.enabled = true,
    this.autocorrect = true,
    this.enabledClear = false,
    this.label = '',
    this.placeholder = '',
    this.prefixIcon,
    this.initialValue = '',
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
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return XTextField(
      focusNode: widget.focusNode,
      obscureText: !_isVisibility,
      enabledClear: widget.enabledClear,
      enabled: widget.enabled,
      autocorrect: widget.autocorrect,
      label: widget.label,
      placeholder: widget.placeholder,
      enabledBorder: widget.enabledBorder,
      disabledBorder: widget.disabledBorder,
      focusedBorder: widget.focusedBorder,
      initialValue: widget.initialValue,
      keyboardType: TextInputType.text,
      prefixIcon: widget.prefixIcon,
      padding: widget.padding,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      onValid: widget.onValid,
      onFieldSubmitted: widget.onFieldSubmitted,
      suffixIcon: _buildSuffixIcon(),
      validationRules: widget.validationRules,
      autoValidateMode: widget.autoValidateMode,
    );
  }

  Widget _buildSuffixIcon() {
    return XIconButton(
      onPressed: () {
        setState(() {
          _isVisibility = !_isVisibility;
        });
      },
      icon: Icon(
        size: 20,
        color: context.iconColor,
        _isVisibility
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
      ),
    );
  }
}
