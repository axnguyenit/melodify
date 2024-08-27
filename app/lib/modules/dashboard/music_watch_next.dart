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
            child: Column(
              children: [
                ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    height: 900,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.label),
                            title: Text('Item ${index + 1}'),
                            subtitle: Text('Subtitle ${index + 1}'),
                          );
                        },
                      ),
                    ),
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


/// To hide bottom sheet when scroll on top on ListView
/// • Create NotificationListener<ScrollNotification> to listen ListView scroll
/// • Call BottomSheet controller when go to top of ListView