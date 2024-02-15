import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? backgroundColor;
  final Widget child;
  final Border? border;
  final InteractiveInkFeatureFactory? splashFactory;

  const InkWellButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius,
    this.highlightColor,
    this.backgroundColor,
    this.splashColor,
    required this.child,
    this.border,
    this.splashFactory,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          color: backgroundColor ?? Colors.transparent,
          border: border,
        ),
        child: InkWell(
          onTap: onPressed,
          onLongPress: onLongPress,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
