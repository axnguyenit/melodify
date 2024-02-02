import 'dart:math';

import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

class XAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  const XAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 40.0,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.border,
    this.boxShadow,
  })  : assert(
          !(imageUrl == null && name == null),
          '''Provide at least [imageUrl] or [name], and [name] can not be an empty string in XAvatar''',
        ),
        assert(
          !(imageUrl == null && name == ''),
          '[name] can not be an empty string in XAvatar',
        );

  BorderRadius get _borderRadius =>
      borderRadius ?? BorderRadius.circular(100.0);

  Color? get _avatarBackground =>
      color ??
      Colors.primaries[Random().nextInt(
        Colors.primaries.length,
      )];

  Widget _buildAvatarWithoutImage(BuildContext context) {
    return Text(
      name!.substring(0, 1).toUpperCase(),
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: border,
        borderRadius: _borderRadius,
        color: _avatarBackground,
        boxShadow: boxShadow,
      ),
      child: imageUrl == null
          ? _buildAvatarWithoutImage(context)
          : XNetworkImage(
              imageUrl: imageUrl!,
              borderRadius: _borderRadius,
              width: size,
              height: size,
            ),
    );
  }
}
