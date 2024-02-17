import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class ImageNetworkStory extends Story {
  ImageNetworkStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Image Network',
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const XNetworkImage(
                  width: 90,
                  height: 50,
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                ),
                const SizedBox(height: 16),
                XNetworkImage(
                  width: 200,
                  borderRadius: BorderRadius.circular(999),
                  height: 90,
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                ),
                const SizedBox(height: 16),
                XNetworkImage(
                  width: 400,
                  borderRadius: BorderRadius.circular(999),
                  height: 170,
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
