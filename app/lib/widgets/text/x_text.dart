import 'package:flutter/material.dart';

import 'x_text_extension.dart';

class XText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextStyleEnum xStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const XText(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.displayLarge(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.displayLarge,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.displayMedium(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.displayMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.displaySmall(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.displaySmall,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineLarge(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.headlineLarge,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineMedium(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.headlineMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineSmall(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.headlineSmall,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleLarge(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.titleLarge,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleMedium(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.titleMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleSmall(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.titleSmall,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodyLarge(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.bodyLarge,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodyMedium(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodySmall(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.bodySmall,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelLarge(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.labelLarge,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelMedium(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.labelMedium,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelSmall(
    this.text, {
    super.key,
    this.style,
    this.xStyle = TextStyleEnum.labelSmall,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  factory XText.custom(
    String text, {
    Key? key,
    TextStyle? style,
    TextStyleEnum xStyle = TextStyleEnum.labelSmall,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return XText(
      text,
      key: key,
      style: style,
      xStyle: xStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  XText customWith(
    BuildContext context, {
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
  }) {
    final currentStyle = style ?? xStyle.getTextStyle(context);
    return XText(
      text,
      key: key,
      xStyle: xStyle,
      style: currentStyle?.copyWith(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ?? xStyle.getTextStyle(context),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
