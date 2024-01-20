import 'dart:ui';

import 'package:flutter/material.dart';

class BaseXDialog extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const BaseXDialog({
    super.key,
    required this.context,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;

  Future<T?> show<T>() async {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(100),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (
        BuildContext _,
        Animation<double> __,
        Animation<double> ___,
      ) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: build(context),
        );
      },
    );
  }
}
