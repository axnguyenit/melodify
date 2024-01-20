import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.image,
    this.width,
    this.height,
  });

  final String image;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppImages.errorImage,
          width: width,
          height: height,
        );
      },
    );
  }
}
