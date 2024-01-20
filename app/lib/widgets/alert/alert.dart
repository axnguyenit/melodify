import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';
import 'package:melodify/widgets/widgets.dart';

part 'enums.dart';

class Alert extends StatelessWidget {
  final String message;
  final int maxLines;
  final AlertSeverity severity;
  final AlertVariant variant;
  final Widget? action;
  final List<BoxShadow>? boxShadow;
  final bool isToast;

  const Alert({
    super.key,
    required this.message,
    this.maxLines = 2,
    this.severity = AlertSeverity.info,
    this.variant = AlertVariant.simple,
    this.action,
    this.boxShadow,
    this.isToast = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    return Material(
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 56,
        decoration: BoxDecoration(
          color: isToast
              ? context.backgroundColor
              : variant.backgroundColor(severity.color),
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: isToast ? severity.color.withOpacity(0.16) : null,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                severity.icon,
                color: variant.iconColor(severity.color),
                size: 24.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: XText(
                message,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                textAlign: TextAlign.start,
              ).customWith(
                context,
                color: isToast
                    ? null
                    : variant.textColor(
                        context,
                        severity.color,
                      ),
              ),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
