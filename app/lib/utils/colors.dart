import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<List<Color>> getLinearColorsFromImage({
  required ImageProvider imageProvider,
}) async {
  final paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  final PaletteGenerator(:dominantColor, :darkVibrantColor, :lightMutedColor) =
      paletteGenerator;
  // final  dominantColor =  dominantColor?.color ?? Colors.black;
  // final Color darkMutedColor = darkMutedColor?.color ?? Colors.black;
  final Color darkMutedColor = darkVibrantColor?.color ?? Colors.black;
  // final Color lightMutedColor = lightMutedColor?.color ?? dominantColor;
  if ((dominantColor?.color ?? Colors.black).computeLuminance() <
      darkMutedColor.computeLuminance()) {
    // checks if the luminance of the darkMuted color is > than the luminance of the dominant
    return [
      darkMutedColor,
      dominantColor?.color ?? Colors.black,
    ];
  } else if (dominantColor == darkMutedColor) {
    // if the two colors are the same, it will replace dominantColor by lightMutedColor
    // GetIt.I<MyTheme>().playGradientColor = [
    //   lightMutedColor,
    //   darkMutedColor,
    // ];
    return [
      lightMutedColor?.color ?? (dominantColor?.color ?? Colors.black),
      darkMutedColor,
    ];
  } else {
    return [
      (dominantColor?.color ?? Colors.black),
      darkMutedColor,
    ];
  }
}
