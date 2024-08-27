import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class Confirmation extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String message;
  final String? okTitle;
  final String? cancelTitle;

  const Confirmation({
    super.key,
    this.icon,
    this.title = '',
    required this.message,
    this.okTitle,
    this.cancelTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBounce(
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(0),
        title: SizedBox(
          width: context.screenWidth * 0.6,
          child: SpanLabel(text: message, textAlign: TextAlign.center),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Divider(height: 1),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWellButton(
                      height: AppConstants.formFieldHeight,
                      borderRadius: BorderRadius.zero,
                      child: Center(
                        child: Text(
                          cancelTitle ?? 'Cancel',
                          style: context.labelMedium,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: InkWellButton(
                      height: AppConstants.formFieldHeight,
                      borderRadius: BorderRadius.zero,
                      child: Center(
                        child: Text(
                          okTitle ?? 'OK',
                          style: context.labelMedium,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
