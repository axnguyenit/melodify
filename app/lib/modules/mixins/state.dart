import 'dart:async';

import 'package:flutter/material.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void postFrame(FutureOr<void> Function() callback) {
    return WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (mounted) await callback();
      },
    );
  }
}
