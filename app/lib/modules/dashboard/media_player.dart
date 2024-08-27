import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/mixins/state.dart';
import 'package:melodify/modules/player/player_controls.dart';
import 'package:melodify/widgets/widgets.dart';

import 'media_info.dart';
import 'media_player_controller.dart';
import 'music_watch_next.dart';

part 'player_header_action.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer>
    with StateMixin, SingleTickerProviderStateMixin {
  final _controller = MediaPlayerController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: _controller.initialPlayerChildSize(context),
      minChildSize: _controller.minPlayerChildSize(context),
      controller: _controller.playerDraggableScroll,
      builder: (context, scrollController) {
        return StreamBuilder<MediaItem?>(
          stream: di.get<AppAudioHandler>().mediaItem,
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot.data == null) {
              return const SizedBox.shrink();
            }

            final mediaItem = snapshot.data!;
            unawaited(_controller.getGradientColors(mediaItem));

            return Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: InkWellButton(
                            onPressed: () {
                              _controller
                                  .playerAnimateToMaxSizeIfNeeded(context);
                            },
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: _controller.gradientColors(context),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        _controller.horizontalPadding(context),
                                  ).copyWith(right: _controller.rightPadding()),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PlayerHeaderAction(
                                        hidden: _controller.playerSize <= 0.8,
                                        height: _controller
                                            .replacedHeaderHeight(context),
                                      ),
                                      SizedBox(
                                        height: _controller.artSize(context),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            XNetworkImage(
                                              imageUrl:
                                                  mediaItem.artUri.toString(),
                                              fit: BoxFit.cover,
                                              height:
                                                  _controller.artSize(context),
                                              width:
                                                  _controller.artSize(context),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12 * _controller.playerSize,
                                              ),
                                            ),
                                            if (_controller.playerSize <= 0.5)
                                              const SizedBox(width: 16),
                                            Flexible(
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                child: _controller.playerSize >
                                                        0.2
                                                    ? const SizedBox.shrink()
                                                    : Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            child: MediaInfo(
                                                              mediaItem:
                                                                  mediaItem,
                                                              titleHeight: 18,
                                                              authorHeight: 14,
                                                              titleStyle: context
                                                                  .titleSmall,
                                                              authorStyle: context
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                color: context
                                                                    .iconColor,
                                                              ),
                                                            ),
                                                          ),
                                                          StreamBuilder<
                                                              PlaybackState>(
                                                            stream: di
                                                                .get<
                                                                    AppAudioHandler>()
                                                                .playbackState
                                                                .stream,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                log
                                                                  ..error(
                                                                      'MINI PLAYER ERROR --> ${snapshot.error}')
                                                                  ..error(snapshot
                                                                      .stackTrace);
                                                                return const SizedBox
                                                                    .shrink();
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
                                                              VoidCallback?
                                                                  onPressed;
                                                              if (snapshot.data
                                                                      ?.playing ??
                                                                  false) {
                                                                icon =
                                                                    Icons.pause;
                                                                onPressed = di
                                                                    .get<
                                                                        AppAudioHandler>()
                                                                    .pause;
                                                              } else {
                                                                icon = Icons
                                                                    .play_arrow;
                                                                onPressed = di
                                                                    .get<
                                                                        AppAudioHandler>()
                                                                    .play;
                                                              }

                                                              return XIconButton(
                                                                icon: Icon(icon,
                                                                    size: 28,
                                                                    color: context
                                                                        .textColor),
                                                                onPressed:
                                                                    onPressed,
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                transitionBuilder:
                                                    (child, animation) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: _controller.playerSize <= 0.8
                                            ? const SizedBox.shrink()
                                            : Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 56),
                                                  MediaInfo(
                                                    mediaItem: mediaItem,
                                                    titleHeight: 36,
                                                    authorHeight: 28,
                                                    titleStyle:
                                                        context.headlineMedium,
                                                    authorStyle: context
                                                        .bodyLarge
                                                        ?.copyWith(
                                                      color: context.iconColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 24),
                                                  PlayerControls(
                                                      mediaItem: mediaItem),
                                                ],
                                              ),
                                        transitionBuilder: (child, animation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      opacity: _controller.playerSize < 0.95 ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: MusicWatchNext(controller: _controller),
                    );
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
