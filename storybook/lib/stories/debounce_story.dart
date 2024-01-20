import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class DebounceStory extends Story {
  DebounceStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Debounce',
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DebounceBuilder(
                  delay: const Duration(milliseconds: 2000),
                  builder: (context, debounce) {
                    return TextField(
                      onChanged: (value) => debounce(() => log.info(value)),
                    );
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
