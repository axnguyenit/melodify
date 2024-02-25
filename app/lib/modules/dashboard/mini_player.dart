import 'package:audio_service/audio_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/context_extension.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';

class MiniPlayer extends StatelessWidget {
  final MediaItem mediaItem;

  const MiniPlayer({
    super.key,
    required this.mediaItem,
  });

  Widget _buildDuration(BuildContext context, double? maxDuration) {
    maxDuration ??= 180.0;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: context.textColor,
        inactiveTrackColor: context.disabledBackgroundColor,
        trackHeight: 1,
        thumbColor: context.textColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        trackShape: const RectangularSliderTrackShape(),
      ),
      child: StreamBuilder<Duration>(
          stream: AudioService.position,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();

            final duration = snapshot.data!;
            final durationInSeconds = duration.inSeconds.toDouble();

            if (durationInSeconds < 0.0 || (durationInSeconds > maxDuration!)) {
              return const SizedBox.shrink();
            }

            return Slider(
              value: durationInSeconds,
              max: maxDuration,
              onChanged: (newPosition) {
                di
                    .get<AppAudioHandler>()
                    .seek(Duration(seconds: newPosition.round()));
              },
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('mini_player'),
      direction: DismissDirection.vertical,
      confirmDismiss: (DismissDirection direction) {
        if (direction == DismissDirection.down) {
          di.get<AppAudioHandler>().stop();
        } else if (direction == DismissDirection.startToEnd) {
          di.get<AppAudioHandler>().skipToPrevious();
        } else if (direction == DismissDirection.endToStart) {
          di.get<AppAudioHandler>().skipToNext();
        } else {
          Routing().pushNamed(Routes.player);
        }
        return Future.value(false);
      },
      child: Container(
        color: context.cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      Routing().pushNamed(Routes.player);
                    },
                    title: Text(
                      mediaItem.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium?.copyWith(
                        color: context.textColor,
                      ),
                    ),
                    subtitle: Text(
                      mediaItem.artist ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        color: context.iconColor,
                      ),
                    ),
                    leading: XNetworkImage(
                      imageUrl: mediaItem.artUri.toString(),
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                StreamBuilder<PlaybackState>(
                  stream: di.get<AppAudioHandler>().playbackState.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      log
                        ..error('MINI PLAYER ERROR --> ${snapshot.error}')
                        ..error(snapshot.stackTrace);
                      return const SizedBox.shrink();
                    }

                    // final processingState = playerState?.processingState;
                    // if (processingState == AudioProcessingState.loading ||
                    //     processingState == AudioProcessingState.buffering) {
                    //   return const SizedBox(
                    //     width: 28,
                    //     height: 28,
                    //     child: CircularProgressIndicator(),
                    //   );
                    // } else
                    IconData icon;
                    VoidCallback? onPressed;
                    if (snapshot.data?.playing ?? false) {
                      icon = Icons.pause;
                      onPressed = di.get<AppAudioHandler>().pause;
                    } else {
                      icon = Icons.play_arrow;
                      onPressed = di.get<AppAudioHandler>().play;
                    }

                    return XIconButton(
                      icon: Icon(icon, size: 28, color: context.textColor),
                      onPressed: onPressed,
                    );
                  },
                ),
              ],
            ),
            _buildDuration(context, mediaItem.duration?.inSeconds.toDouble()),
          ],
        ),
      ),
    );
  }
}
