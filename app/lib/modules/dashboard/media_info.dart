import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

class MediaInfo extends StatelessWidget {
  final MediaItem mediaItem;
  final double titleHeight;
  final double authorHeight;
  final TextStyle? titleStyle;
  final TextStyle? authorStyle;

  const MediaInfo({
    super.key,
    required this.mediaItem,
    required this.titleHeight,
    required this.authorHeight,
    this.titleStyle,
    this.authorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleTextPainter = TextPainter(
          text: TextSpan(
            text: mediaItem.title,
            style: titleStyle,
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(
            minWidth: 0,
            maxWidth: constraints.maxWidth,
          );

        Widget titleWidget;
        if (titleTextPainter.didExceedMaxLines) {
          titleWidget = SizedBox(
            height: titleHeight,
            child: Marquee(
              text: mediaItem.title,
              style: titleStyle,
              blankSpace: 44,
              velocity: 28,
              startAfter: const Duration(seconds: 2),
            ),
          );
        } else {
          titleWidget = Text(
            mediaItem.title,
            style: titleStyle,
          );
        }

        final authorTextPainter = TextPainter(
          text: TextSpan(
            text: mediaItem.artist!,
            style: authorStyle,
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(
            minWidth: 0,
            maxWidth: constraints.maxWidth,
          );

        Widget authorWidget;
        if (authorTextPainter.didExceedMaxLines) {
          authorWidget = SizedBox(
            height: authorHeight,
            child: Marquee(
              text: mediaItem.artist!,
              style: authorStyle?.copyWith(
                color: context.iconColor,
              ),
              blankSpace: 44,
              velocity: 28,
              startAfter: const Duration(seconds: 2),
            ),
          );
        } else {
          authorWidget = Text(
            mediaItem.artist!,
            style: authorStyle?.copyWith(
              color: context.iconColor,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [titleWidget, authorWidget],
        );
      },
    );
  }
}
