import 'package:flutter/material.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void postFrame(VoidCallback callback) {
    return WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (mounted) callback();
      },
    );
  }
}
