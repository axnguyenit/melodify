part of 'mini_player.dart';

class MediaItemWidget extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaItemWidget({
    super.key,
    required this.mediaItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => Routing().pushNamed(Routes.player),
      title: LayoutBuilder(
        builder: (context, constraints) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: mediaItem.title,
              style: context.titleSmall,
            ),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout(
              minWidth: 0,
              maxWidth: constraints.maxWidth,
            );

          if (textPainter.didExceedMaxLines) {
            return SizedBox(
              height: 18,
              child: Marquee(
                text: mediaItem.title,
                style: context.titleSmall,
                blankSpace: 44,
                velocity: 28,
                startAfter: const Duration(seconds: 2),
              ),
            );
          }

          return Text(
            mediaItem.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleSmall?.copyWith(
              color: context.textColor,
            ),
          );
        },
      ),
      subtitle: Text(
        mediaItem.artist ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          color: context.iconColor,
        ),
      ),
      // leading: XNetworkImage(
      //   imageUrl: mediaItem.artUri.toString(),
      //   width: 48,
      //   height: 48,
      //   fit: BoxFit.fitHeight,
      // ),
      contentPadding: const EdgeInsets.only(
        left: AppConstants.appPadding,
      ),
    );
  }
}
