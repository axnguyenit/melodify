import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

class XNetworkImage extends StatelessWidget {
  const XNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.fit,
  });

  final double? width;
  final double? height;
  final String imageUrl;
  final BorderRadius borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => Image.asset(
        AppImages.discFill,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      ),
      errorWidget: (context, url, error) => Image.asset(
        AppImages.errorFill,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
