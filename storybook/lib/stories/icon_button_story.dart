import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class IconButtonStory extends Story {
  IconButtonStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Icon Button',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XIconButton(
                  onPressed: noop,
                  icon: Icon(
                    Icons.check_circle_rounded,
                    color: context.primaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                XIconButton(
                  minWidth: 56,
                  onPressed: noop,
                  icon: Icon(
                    Icons.check_circle_rounded,
                    color: context.primaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                XIconButton(
                  minWidth: 56,
                  onPressed: noop,
                  icon: Icon(
                    Icons.check_circle_rounded,
                    color: context.primaryColor,
                  ),
                  border: Border.all(
                    color: context.borderColor,
                    width: 1,
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
