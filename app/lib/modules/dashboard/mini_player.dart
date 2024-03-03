import 'package:audio_service/audio_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';

import 'media_duration.dart';
part 'media_item_widget.dart';

class MiniPlayer extends StatelessWidget {
  final MediaItem mediaItem;

  const MiniPlayer({
    super.key,
    required this.mediaItem,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Dismissible(
                  key: const Key('mini_player'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      di.get<AppAudioHandler>().skipToPrevious();
                    } else if (direction == DismissDirection.endToStart) {
                      di.get<AppAudioHandler>().skipToNext();
                    }
                  },
                  child: MediaItemWidget(mediaItem: mediaItem),
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
          MediaDuration(maxDuration: mediaItem.duration?.inSeconds.toDouble()),
        ],
      ),
    );
  }
}
