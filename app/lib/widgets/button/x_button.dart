import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';

import '../widgets.dart';

enum XButtonVariant { outline, solid, text }

enum XButtonSize {
  small,
  medium;

  EdgeInsetsGeometry get padding {
    double vertical = 0.0, horizontal = 0.0;
    switch (this) {
      case XButtonSize.small:
        vertical = 10.0;
        horizontal = 16.0;
      case XButtonSize.medium:
        vertical = 14.0;
        horizontal = 22.0;
    }

    return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  }

  XText xText(BuildContext context, String title, [Color? color]) {
    switch (this) {
      case XButtonSize.small:
        return XText.labelSmall(title).customWith(context, color: color);
      case XButtonSize.medium:
        return XText.labelMedium(title).customWith(context, color: color);
    }
  }
}

class XButton extends StatelessWidget {
  final bool loading;
  final Color? color;
  final String? title;
  final Widget? child;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final XButtonSize size;
  final XButtonVariant variant;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;

  // ────────────────────────────────────────────

  const XButton({
    super.key,
    this.loading = false,
    this.color,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.solid,
    this.onPressed,
    this.borderRadius,
  });

  const XButton.primary({
    super.key,
    this.loading = false,
    this.color,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.solid,
    this.onPressed,
    this.borderRadius,
  });

  const XButton.outlined({
    super.key,
    this.loading = false,
    this.color,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.outline,
    this.onPressed,
    this.borderRadius,
  });

  const XButton.positive({
    super.key,
    this.loading = false,
    this.color = Palette.positive,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.solid,
    this.onPressed,
    this.borderRadius,
  });

  const XButton.negative({
    super.key,
    this.loading = false,
    this.color = Palette.negative,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.solid,
    this.onPressed,
    this.borderRadius,
  });

  const XButton.text({
    super.key,
    this.loading = false,
    this.color,
    this.title,
    this.child,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.size = XButtonSize.medium,
    this.variant = XButtonVariant.text,
    this.onPressed,
    this.borderRadius,
  });

  // ────────────────────────────────────────────

  Color _buildTextColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledColor;

    switch (variant) {
      case XButtonVariant.solid:
        return Palette.text.primaryDark;
      case XButtonVariant.outline:
      case XButtonVariant.text:
        return color ?? context.primaryColor;
    }
  }

  Color _buildFillColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    switch (variant) {
      case XButtonVariant.solid:
        return color ?? context.primaryColor;
      case XButtonVariant.outline:
      case XButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color? _buildHighlightColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    switch (variant) {
      case XButtonVariant.solid:
        return context.cardColor.withOpacity(0.15);
      case XButtonVariant.outline:
      case XButtonVariant.text:
        return color?.withOpacity(0.15) ??
            context.primaryColor.withOpacity(0.15);
    }
  }

  Color _buildBorderColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    switch (variant) {
      case XButtonVariant.solid:
      case XButtonVariant.outline:
        return color ?? context.primaryColor;
      case XButtonVariant.text:
        return Colors.transparent;
    }
  }

  BorderSide _border(BuildContext context, bool disabled) {
    if (disabled || loading) return BorderSide.none;

    switch (variant) {
      case XButtonVariant.solid:
      case XButtonVariant.outline:
        return BorderSide(
          width: 1.0,
          color: _buildBorderColor(context, disabled),
        );
      case XButtonVariant.text:
        return BorderSide.none;
    }
  }

  Widget _buildLoadingIcon(Color color) {
    return SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2.0,
      ),
    );
  }

  Widget _buildChild(BuildContext context, bool disabled) {
    final textColor = _buildTextColor(context, disabled);
    if (child != null) return child!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        XText.labelLarge(title).customWith(context, color: textColor),
        if (suffixIcon != null && !loading) ...[
          const SizedBox(width: 8),
          suffixIcon!,
        ] else if (loading) ...[
          const SizedBox(width: 8),
          _buildLoadingIcon(textColor),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    return RawMaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      fillColor: _buildFillColor(context, disabled),
      splashColor: _buildHighlightColor(context, disabled),
      hoverColor: _buildHighlightColor(context, disabled),
      highlightColor: _buildHighlightColor(context, disabled),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(
        minHeight: height ?? 0.0,
        maxHeight: height ?? double.infinity,
        minWidth: width ?? 0.0,
        maxWidth: width ?? double.infinity,
      ),
      padding: padding ?? size.padding,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ??
            BorderRadius.circular(AppConstants.formFieldBorderRadius),
        side: _border(context, disabled),
      ),
      onPressed: loading ? null : onPressed,
      child: _buildChild(context, disabled),
    );
  }
}
