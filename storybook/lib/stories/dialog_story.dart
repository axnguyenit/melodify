import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class PopupDrawerStory extends Story {
  PopupDrawerStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Dialog',
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XButton.outlined(
                  title: 'Confirm',
                  onPressed: () {
                    final result = XDialog.of(context)
                        .confirmation(
                          title: 'Title',
                          message:
                              'You need to {{sign in}} to continue shopping'
                              '. Do you want to register now?',
                        )
                        .show();
                    if (result is bool) {}
                  },
                ),
                const SizedBox(height: 24),
                XButton.negative(
                  title: 'Show Error',
                  onPressed: () {
                    final result = XDialog.of(context)
                        .alert(
                            title: 'Title',
                            message:
                                'You need to [[sign in]] to continue shopping'
                                '. Do you want to register now?',
                            okTitle: 'Close')
                        .show();
                    if (result is bool) {}
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
