import 'package:flutter/material.dart';

import 'media_player_controller.dart';

class MusicWatchNext extends StatefulWidget {
  final MediaPlayerController controller;

  const MusicWatchNext({
    super.key,
    required this.controller,
  });

  @override
  State<MusicWatchNext> createState() => _MusicWatchNextState();
}

class _MusicWatchNextState extends State<MusicWatchNext> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: widget.controller.initialWatchNextChildSize(context),
      minChildSize: widget.controller.minWatchNextChildSize(context),
      maxChildSize: widget.controller.maxWatchNextChildSize(context),
      controller: widget.controller.watchNextDraggableScroll,
      builder: (context, scrollController) {
        return ColoredBox(
          color: widget.controller.gradientColors(context).last,
          child: SingleChildScrollView(
            controller: scrollController,
            child: const Column(
              children: [
                ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
