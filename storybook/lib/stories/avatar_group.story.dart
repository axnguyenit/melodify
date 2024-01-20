import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class AvatarGroupStory extends Story {
  AvatarGroupStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Avatar Group',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AvatarGroup(
                  avatars: [
                    AvatarModel(name: 'L'),
                    AvatarModel(name: 'A'),
                    AvatarModel(imageUrl: 'https://picsum.photos/200/300'),
                    AvatarModel(name: 'D'),
                    AvatarModel(name: 'K'),
                  ],
                ),
                spacer,
                AvatarGroup(
                  avatars: const [
                    AvatarModel(imageUrl: 'https://picsum.photos/200/300'),
                    AvatarModel(imageUrl: 'https://picsum.photos/200/300'),
                    AvatarModel(imageUrl: 'https://picsum.photos/200/300'),
                  ],
                  avatarBorder: Border.all(color: Colors.white, width: 1),
                ),
                spacer,
                AvatarGroup(
                  max: 4,
                  size: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  borderRadius: BorderRadius.circular(8),
                  avatarBoxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(.25),
                    )
                  ],
                  avatars: const [
                    AvatarModel(name: 'L'),
                    AvatarModel(name: 'A'),
                    AvatarModel(imageUrl: 'https://picsum.photos/200/300'),
                    AvatarModel(name: 'D'),
                    AvatarModel(name: 'K'),
                  ],
                ),
                spacer,
                AvatarGroup(
                  max: 4,
                  size: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  borderRadius: BorderRadius.circular(8),
                  avatarBorder: Border.all(color: Colors.white, width: 1),
                  avatarBoxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(.25),
                    )
                  ],
                  avatars: const [
                    AvatarModel(name: 'L'),
                    AvatarModel(name: 'K'),
                    AvatarModel(name: 'A'),
                    AvatarModel(name: 'D'),
                    AvatarModel(name: 'A'),
                    AvatarModel(name: 'K'),
                    AvatarModel(name: 'D'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
