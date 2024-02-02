import 'package:flutter/material.dart';

class XAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double statusBarHeight;
  final double toolbarHeight;
  final double spacing;

  final Widget? left;
  final Widget center;
  final Widget? right;

  const XAppBar({
    super.key,
    required this.statusBarHeight,
    this.toolbarHeight = 56,
    this.spacing = 12,
    this.left,
    this.center = const SizedBox(),
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: statusBarHeight + toolbarHeight,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          SizedBox(
            height: toolbarHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (left != null) ...[
                  left!,
                  SizedBox(width: spacing),
                ],
                Expanded(child: center),
                if (right != null) ...[
                  SizedBox(width: spacing),
                  right!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(statusBarHeight + toolbarHeight);
}
