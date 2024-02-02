import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/theme/theme.dart';

enum XButtonVariant { outline, solid, text }

enum XButtonSize {
  small,
  medium;

  EdgeInsetsGeometry get padding {
    final [vertical, horizontal] = switch (this) {
      XButtonSize.small => [10.0, 16.0],
      XButtonSize.medium => [14.0, 22.0],
    };

    return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  }

  Text text(BuildContext context, String title, [Color? color]) {
    return switch (this) {
      XButtonSize.small => Text(
          title,
          style: context.labelSmall?.copyWith(color: color),
        ),
      XButtonSize.medium => Text(
          title,
          style: context.labelMedium?.copyWith(color: color),
        ),
    };
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

    return switch (variant) {
      XButtonVariant.solid => Palette.text.primaryDark,
      XButtonVariant.outline ||
      XButtonVariant.text =>
        color ?? context.primaryColor,
    };
  }

  Color _buildFillColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    return switch (variant) {
      XButtonVariant.solid => color ?? context.primaryColor,
      XButtonVariant.outline || XButtonVariant.text => Colors.transparent,
    };
  }

  Color? _buildHighlightColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    return switch (variant) {
      XButtonVariant.solid => context.cardColor.withOpacity(0.15),
      XButtonVariant.outline ||
      XButtonVariant.text =>
        color?.withOpacity(0.15) ?? context.primaryColor.withOpacity(0.15),
    };
  }

  Color _buildBorderColor(BuildContext context, bool disabled) {
    if (disabled || loading) return context.disabledBackgroundColor;

    return switch (variant) {
      XButtonVariant.solid ||
      XButtonVariant.outline =>
        color ?? context.primaryColor,
      XButtonVariant.text => Colors.transparent,
    };
  }

  BorderSide _border(BuildContext context, bool disabled) {
    if (disabled || loading) return BorderSide.none;

    return switch (variant) {
      XButtonVariant.solid || XButtonVariant.outline => BorderSide(
          width: 1.0,
          color: _buildBorderColor(
            context,
            disabled,
          ),
        ),
      XButtonVariant.text => BorderSide.none,
    };
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
        Text(
          title ?? '',
          style: context.labelLarge?.copyWith(
            color: textColor,
          ),
        ),
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
