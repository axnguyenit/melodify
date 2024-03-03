import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/models/extensions/extensions.dart';
import 'package:melodify/models/models.dart';
import 'package:melodify/utils/utils.dart';
import 'package:melodify/widgets/widgets.dart';

class PlayerControls extends StatelessWidget {
  final MediaItem mediaItem;
  const PlayerControls({
    super.key,
    required this.mediaItem,
  });

  Widget _buildDuration(BuildContext context, double? maxDuration) {
    maxDuration ??= 240.0;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: context.textColor,
        inactiveTrackColor: context.disabledBackgroundColor,
        trackHeight: 2,
        thumbColor: context.textColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        trackShape: const RectangularSliderTrackShape(),
      ),
      child: StreamBuilder<Duration>(
        stream: AudioService.position,
        builder: (context, snapshot) {
          final duration = snapshot.data;
          double durationInSeconds = duration?.inSeconds.toDouble() ?? 0.0;

          if (durationInSeconds < 0.0 || (durationInSeconds > maxDuration!)) {
            durationInSeconds = 0.0;
          }

          return Slider(
            value: durationInSeconds,
            max: maxDuration!,
            onChanged: (newPosition) {
              di
                  .get<AppAudioHandler>()
                  .seek(Duration(seconds: newPosition.round()));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWellButton(
              backgroundColor: context.textColor!.withOpacity(0.15),
              onPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              borderRadius: BorderRadius.circular(50),
              child: Row(
                children: [
                  AppIcon(
                    assetName: AppIcons.playlistAdd,
                    color: context.textColor,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Save',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWellButton(
              backgroundColor: context.textColor!.withOpacity(0.15),
              onPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              borderRadius: BorderRadius.circular(50),
              child: Row(
                children: [
                  AppIcon(
                    assetName: AppIcons.shareOutline,
                    color: context.textColor,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Share',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWellButton(
              backgroundColor: context.textColor!.withOpacity(0.15),
              onPressed: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              borderRadius: BorderRadius.circular(50),
              child: Row(
                children: [
                  AppIcon(
                    assetName: AppIcons.download,
                    color: context.textColor,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Download',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),
        StreamBuilder<PositionData>(
          stream: di.get<AppAudioHandler>().positionStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const SizedBox.shrink();
            }
            final positionData = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: _buildDuration(
                    context,
                    mediaItem.duration?.inSeconds.toDouble(),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                              .firstMatch(positionData.position.toString())
                              ?.group(1) ??
                          '${positionData.position}',
                      style: context.bodySmall?.copyWith(
                        color: context.iconColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                              .firstMatch(positionData.duration.toString())
                              ?.group(1) ??
                          '${positionData.duration}',
                      style: context.bodySmall?.copyWith(
                        color: context.iconColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const XIconButton(
                      icon: Icon(Icons.shuffle),
                      onPressed: noop,
                    ),
                    XIconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 32,
                        color: context.textColor,
                      ),
                      onPressed: noop,
                    ),
                    StreamBuilder<PlaybackState>(
                      stream: di.get<AppAudioHandler>().playbackState.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
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
                          background: Colors.white,
                          minWidth: 72,
                          icon: Icon(
                            icon,
                            size: 40,
                            color: Colors.black,
                          ),
                          onPressed: onPressed,
                        );
                      },
                    ),
                    XIconButton(
                      icon: Icon(
                        Icons.skip_next,
                        size: 32,
                        color: context.textColor,
                      ),
                      onPressed: noop,
                    ),
                    StreamBuilder<AudioServiceRepeatMode>(
                      stream: di
                          .get<AppAudioHandler>()
                          .playbackState
                          .map((state) => state.repeatMode)
                          .distinct(),
                      builder: (context, snapshot) {
                        final repeatMode =
                            snapshot.data ?? AudioServiceRepeatMode.none;

                        return XIconButton(
                          icon: repeatMode.icon(context),
                          onPressed: () async {
                            await di
                                .get<AppAudioHandler>()
                                .setRepeatMode(repeatMode.nextRepeatMode);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
