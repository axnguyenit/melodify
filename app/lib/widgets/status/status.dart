import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';

enum XStatusType {
  positive,
  negative,
  pending;

  Icon getIcon() {
    switch (this) {
      case XStatusType.positive:
        return const Icon(
          Icons.check_circle_rounded,
          size: 20,
          color: Palette.positive,
        );
      case XStatusType.negative:
        return const Icon(
          Icons.cancel_rounded,
          size: 20,
          color: Palette.negative,
        );
      case XStatusType.pending:
        return const Icon(
          Icons.error_rounded,
          size: 20,
          color: Palette.warning,
        );
    }
  }
}

class XStatus extends StatelessWidget {
  final XStatusType status;
  final String? label;
  final Color? labelColor;

  const XStatus({
    super.key,
    this.label,
    this.status = XStatusType.positive,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          status.getIcon(),
          // Column(
          //   children: [
          //     status.getIcon(),
          //     const SizedBox(height: 4),
          //   ],
          // ),
          if (label.isNotNullOrEmpty) ...[
            const SizedBox(width: 8),
            Text(
              label!,
              style: context.bodyMedium?.copyWith(
                color: labelColor,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
