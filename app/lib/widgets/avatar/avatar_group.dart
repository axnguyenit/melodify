import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

class AvatarModel {
  final String? imageUrl;
  final String? name;

  const AvatarModel({
    this.imageUrl,
    this.name,
  })  : assert(
          !(imageUrl == null && name == null),
          '''Provide at least [imageUrl] or [name]''',
        ),
        assert(
          !(imageUrl == null && name == ''),
          '[name] can not be an empty string in AvatarModel',
        );
}

class AvatarGroup extends StatelessWidget {
  final int max;
  final double size;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final BoxBorder? avatarBorder;
  final List<AvatarModel> avatars;
  final List<BoxShadow>? avatarBoxShadow;

  const AvatarGroup({
    super.key,
    this.max = 3,
    this.size = 40.0,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.avatarBorder,
    this.avatars = const [],
    this.avatarBoxShadow,
  });

  int get _restAvatarCount => avatars.length - max;

  bool get _hasRestAvatar => _restAvatarCount > 0;

  List<AvatarModel> get _filteredAvatars {
    if (!_hasRestAvatar) return avatars.reversed.toList();

    return avatars.sublist(0, max).reversed.toList();
  }

  double get _width {
    int displayLength = _filteredAvatars.length;
    if (_hasRestAvatar) {
      displayLength = _filteredAvatars.length + 1;
    }

    return displayLength * .75 * size + .25 * size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(
          width: _width,
          height: size,
        ),
        if (_hasRestAvatar) ...[
          Positioned(
            right: 0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(100.0),
                border: avatarBorder,
                boxShadow: avatarBoxShadow,
                color: Colors.primaries[Random().nextInt(
                  Colors.primaries.length,
                )],
              ),
              child: Center(
                child: Text(
                  '+$_restAvatarCount',
                  style: TextStyle(
                    fontSize: fontSize ?? 16,
                    color: Colors.white,
                    fontWeight: fontWeight ?? FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
        ..._filteredAvatars.mapIndex(
          (avatar, index) => Positioned(
            right: size * (index + (_hasRestAvatar ? 1 : 0)) * 0.75,
            child: XAvatar(
              size: size,
              fontSize: fontSize,
              fontWeight: fontWeight,
              borderRadius: borderRadius,
              border: avatarBorder,
              imageUrl: avatar.imageUrl,
              name: avatar.name,
              boxShadow: avatarBoxShadow,
            ),
          ),
        ),
      ],
    );
  }
}
