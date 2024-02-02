import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class XTextField extends StatefulWidget {
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool enabledClear;

  final int minLines;
  final int maxLines;

  final String? label;
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? initialValue;

  final EdgeInsets? padding;
  final EdgeInsets scrollPadding;

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;

  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  final void Function(String? value)? onValid;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onFieldSubmitted;

  final List<ValidationRule> validationRules;
  final AutovalidateMode? autoValidateMode;

  const XTextField({
    super.key,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enabledClear = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.label,
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.initialValue,
    this.padding,
    this.scrollPadding = const EdgeInsets.all(20),
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.inputFormatters,
    this.onValid,
    this.onFieldSubmitted,
    this.onChanged,
    this.validationRules = const [],
    this.autoValidateMode,
  });

  @override
  State<XTextField> createState() => _XTextFieldState();
}

class _XTextFieldState extends State<XTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  // @override
  // void didUpdateWidget(covariant XTextField oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (oldWidget.initialValue != widget.initialValue) {
  //     _controller.text = widget.initialValue ?? '';
  //   }
  // }

  Row _buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // if (isEditing && widget.enabledClear) ...[
        //   XIconButton(
        //     onPressed: _controller.clear,
        //     icon: Icon(
        //       Icons.clear,
        //       size: 20,
        //       color: context.iconColor,
        //     ),
        //   )
        // ],
        if (widget.suffixIcon != null) ...[
          widget.suffixIcon!,
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      scrollPadding: widget.scrollPadding,
      inputFormatters: widget.inputFormatters,
      cursorColor: context.textColor,
      cursorWidth: 1.0,
      style: context.bodyMedium?.copyWith(
        color: widget.enabled ? context.textColor : context.disabledColor,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      autocorrect: widget.autocorrect,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      autovalidateMode: widget.autoValidateMode,
      validator: widget.validationRules.validate,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        labelText: widget.label,
        prefixText: widget.prefixText,
        contentPadding: widget.padding,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }
}
