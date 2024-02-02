import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';

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
    return Text(
      message,
      style: (style ?? context.bodySmall)?.copyWith(
        color: status.color,
      ),
    );
  }
}
