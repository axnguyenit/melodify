import 'package:flutter/material.dart';

class BaseModalBottomSheet extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const BaseModalBottomSheet({
    super.key,
    required this.context,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;

  Future<T?> show<T>() async {
    return showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1,
      builder: build,
    );
  }
}
