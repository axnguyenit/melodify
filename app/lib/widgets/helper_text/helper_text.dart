import 'package:flutter/material.dart';
import 'package:melodify/theme/theme.dart';
import 'package:melodify/widgets/widgets.dart';

part 'helper_text_status.dart';

class HelperText extends StatelessWidget {
  final String message;
  final HelperTextStatus status;
  final TextStyle? style;

  const HelperText({
    super.key,
    required this.message,
    this.status = HelperTextStatus.information,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return XText.bodySmall(
      message,
      style: style,
    ).customWith(context, color: status.color);
  }
}
