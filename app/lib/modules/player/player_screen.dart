import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/constants/context_extension.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/utils/utils.dart';
import 'package:melodify/widgets/widgets.dart';

import 'player_controls.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends BaseScreen<PlayerScreen> {
  final _gradientColors =
      ValueNotifier<List<Color>>([Colors.black, Colors.black]);
  final _draggableScrollController = DraggableScrollableController();
  bool _hasFirstBuild = false;

  @override
  void initState() {
    super.initState();

    _draggableScrollController.addListener(_draggableListener);
    postFrame(() {
      _hasFirstBuild = true;
    });
  }

  @override
  void dispose() {
    _draggableScrollController
      ..removeListener(_draggableListener)
      ..dispose();

    super.dispose();
  }

  void _draggableListener() {
    // log.warning(_draggableScrollController.pixels);
    // log.warning(_draggableScrollController
    //     .pixelsToSize(_draggableScrollController.pixels));
    // if (_draggableScrollController.size >= 0.5) {
    //   _draggableScrollController.animateTo(
    //     0.8,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.linear,
    //   );
    // }
  }

  Future<void> _getGradientColors(MediaItem mediaItem) async {
    final colors = await getLinearColorsFromImage(
        imageProvider: CachedNetworkImageProvider(mediaItem.artUri.toString()));
    _gradientColors.value = colors;
  }

  // @override
  // bool get extendBodyBehindAppBar => true;

  // @override
  // PreferredSizeWidget? get buildAppBar {
  //   return AppBar(
  //     leading: XIconButton(
  //       icon: Icon(
  //         Icons.keyboard_arrow_down_rounded,
  //         color: context.textColor,
  //       ),
  //       onPressed: router.pop,
  //     ),
  //     actions: [
  //       XIconButton(
  //         icon: Icon(
  //           Icons.more_vert_rounded,
  //           color: context.textColor,
  //         ),
  //         onPressed: router.pop,
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return buildBody;
  }

  double _pixelsToSize(double pixels) {
    return pixels / screenHeight * screenHeight;
  }

  double get _initialChildSize {
    if (_hasFirstBuild) return _draggableScrollController.pixelsToSize(116);
    return 116 / screenHeight;
  }

  double get _minChildSize {
    if (_hasFirstBuild) return _draggableScrollController.pixelsToSize(116);
    return 116 / screenHeight;
  }

  @override
  Widget get buildBody {
    return Dismissible(
      direction: DismissDirection.down,
      background: const ColoredBox(color: Colors.transparent),
      key: const Key('playScreen'),
      onDismissed: (_) => router.pop(),
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<MediaItem?>(
              stream: di.get<AppAudioHandler>().mediaItem,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();

                final mediaItem = snapshot.data!;
                _getGradientColors(mediaItem);

                return ValueListenableBuilder(
                  valueListenable: _gradientColors,
                  child: Padding(
                    padding: EdgeInsets.all(horizontalPadding)
                        .copyWith(top: statusBarHeight),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            XIconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: context.textColor,
                              ),
                              onPressed: router.pop,
                            ),
                            XIconButton(
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: context.textColor,
                              ),
                              onPressed: noop,
                            ),
                          ],
                        ),
                        const SizedBox(height: 52),
                        XNetworkImage(
                          imageUrl: mediaItem.artUri.toString(),
                          fit: BoxFit.cover,
                          height: screenWidth - 64,
                          width: screenWidth - 64,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(height: 48),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final textPainter = TextPainter(
                                text: TextSpan(
                                  text: mediaItem.title,
                                  style: context.headlineMedium,
                                ),
                                maxLines: 1,
                                textDirection: TextDirection.ltr,
                              )..layout(
                                  minWidth: 0,
                                  maxWidth: constraints.maxWidth,
                                );

                              if (textPainter.didExceedMaxLines) {
                                return SizedBox(
                                  height: 36,
                                  child: Marquee(
                                    text: mediaItem.title,
                                    style: context.headlineMedium,
                                    blankSpace: 44,
                                    velocity: 28,
                                    startAfter: const Duration(seconds: 2),
                                  ),
                                );
                              }

                              return Text(
                                mediaItem.title,
                                style: context.headlineMedium,
                              );
                            },
                          ),
                        ),
                        Text(
                          mediaItem.artist!,
                          style: context.bodyLarge?.copyWith(
                            color: context.iconColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            // Text(mediaItem.extras!['viewCount'].toString()),
                            const SizedBox(width: 8),
                            InkWellButton(
                              backgroundColor:
                                  context.textColor!.withOpacity(0.15),
                              onPressed: () {},
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              child: const Text(
                                'Save',
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWellButton(
                              backgroundColor:
                                  context.textColor!.withOpacity(0.15),
                              onPressed: () {},
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              child: const Text(
                                'Download',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        PlayerControls(mediaItem: mediaItem),
                      ],
                    ),
                  ),
                  builder: (context, value, child) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: value,
                        ),
                      ),
                      child: child,
                    );
                  },
                );
              },
            ),
            DraggableScrollableSheet(
              initialChildSize: _initialChildSize,
              minChildSize: _minChildSize,
              controller: _draggableScrollController,
              snap: true,
              shouldCloseOnMinExtent: false,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: ColoredBox(
                    color: Colors.grey,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          SizedBox(height: statusBarHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              XIconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: context.textColor,
                                ),
                                onPressed: () {
                                  _draggableScrollController.animateTo(
                                    0.0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                              ),
                              XIconButton(
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: context.textColor,
                                ),
                                onPressed: noop,
                              ),
                            ],
                          ),
                          const SizedBox(height: 52),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
