import 'package:flutter/material.dart';

class XIconButton extends StatelessWidget {
  final Widget icon;
  final double? iconSize;
  final double? minWidth;
  final BoxBorder? border;
  final Color? background;
  final VoidCallback? onPressed;

  const XIconButton({
    super.key,
    this.border,
    this.minWidth,
    this.iconSize,
    this.onPressed,
    this.background,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        splashRadius: (minWidth ?? 45) - 25,
        iconSize: iconSize ?? 22,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 36,
          minHeight: minWidth ?? 36,
        ),
        icon: icon,
      ),
    );
  }
}
