import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class XAlertDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String message;
  final String? okTitle;

  const XAlertDialog({
    super.key,
    this.icon,
    this.title = '',
    required this.message,
    this.okTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBounce(
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(0),
        title: SizedBox(
          width: AppConstants.screenSize.width * 0.6,
          child: SpanLabel(text: message, textAlign: TextAlign.center),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Divider(height: 1),
            InkWellButton(
              height: AppConstants.formFieldHeight,
              borderRadius: BorderRadius.zero,
              child: Center(
                child: XText.labelMedium(okTitle ?? 'Close'),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
