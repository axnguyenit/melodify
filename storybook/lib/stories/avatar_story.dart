import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class AvatarStory extends Story {
  AvatarStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Avatar',
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XAvatar(
                  name: 'Ax Nguyen',
                ),
                SizedBox(height: 16),
                XAvatar(
                  size: 60,
                  name: 'Ax Nguyen',
                ),
                SizedBox(height: 16),
                XAvatar(
                  size: 80,
                  color: Colors.grey,
                  name: 'Ax Nguyen',
                ),
                SizedBox(height: 16),
                XAvatar(
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                  name: 'Ax Nguyen',
                ),
                SizedBox(height: 16),
                XAvatar(
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                  name: 'Ax Nguyen',
                  size: 60,
                ),
                SizedBox(height: 16),
                XAvatar(
                  imageUrl:
                      'http://images2.fanpop.com/image/photos/9400000/wallpaper-2-james-camerons-avatar-9473513-900-563.jpg',
                  name: 'Ax Nguyen',
                  size: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
