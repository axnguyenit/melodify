import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

import 'ink_well_button.dart';

class XLinkButton extends StatelessWidget {
  final Color color;
  final String title;
  final double? fontSize;
  final TextStyle? textStyle;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final GestureTapCallback onPressed;

  const XLinkButton({
    super.key,
    this.color = const Color(0xFF0571FA),
    required this.title,
    this.shadows,
    this.fontSize,
    this.textStyle,
    required this.onPressed,
    this.decoration,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: context.bodyMedium?.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w600,
          decoration: decoration ?? TextDecoration.none,
          decorationColor: color,
          decorationThickness: 1,
        ),
      ),
    );
  }
}
