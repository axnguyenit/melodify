import 'package:flutter/material.dart';

import 'mark_text_styles.dart';

extension SpanLabelTheme on ThemeData {
  TextStyle? get spanLabelDefaultStyle => textTheme.bodySmall;

  TextStyle? get spanLabelBoldStyle => textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
      );

  TextStyle? get spanLabelItalicStyle => textTheme.bodySmall?.copyWith(
        fontStyle: FontStyle.italic,
      );

  TextStyle? get spanLabelBoldItalicStyle => textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      );
}

class Tag {
  static const String startBold = '[[';
  static const String endBold = ']]';

  static const String startItalic = '{{';
  static const String endItalic = '}}';

  static const String startBoldItalic = '[{';
  static const String endBoldItalic = '}]';
}

enum CurrencyStyle { style1, style2, style3 }

class SpanLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final CurrencyStyle currencyStyle;

  final TextStyle? defaultStyle;
  final TextStyle? boldStyle;
  final TextStyle? italicStyle;
  final TextStyle? boldItalicStyle;

  const SpanLabel({
    super.key,
    required this.text,
    this.fontSize = 15.0,
    this.textAlign = TextAlign.left,
    this.currencyStyle = CurrencyStyle.style3,
    this.defaultStyle,
    this.boldStyle,
    this.italicStyle,
    this.boldItalicStyle,
  });

  List<AppTextSpan> _allTextSpans(BuildContext context) {
    return [
      AppTextSpan(
        Tag.startBold,
        Tag.endBold,
        boldStyle ??
            _applyColorAndFontSize(Theme.of(context).spanLabelBoldStyle),
      ),
      AppTextSpan(
        Tag.startItalic,
        Tag.endItalic,
        italicStyle ??
            _applyColorAndFontSize(Theme.of(context).spanLabelItalicStyle),
      ),
      AppTextSpan(
        Tag.startBoldItalic,
        Tag.endBoldItalic,
        boldItalicStyle ??
            _applyColorAndFontSize(Theme.of(context).spanLabelBoldStyle),
      ),
    ];
  }

  TextStyle? _applyColorAndFontSize(TextStyle? textStyle) {
    return textStyle?.copyWith(fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: defaultStyle ??
            _applyColorAndFontSize(
              Theme.of(context).spanLabelDefaultStyle,
            ),
        children: AppTextSpan.buildTextSpans(text, _allTextSpans(context)),
      ),
    );
  }
}
