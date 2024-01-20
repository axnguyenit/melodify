import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class TemplateStory extends Story {
  TemplateStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Template Storybook',
      builder: (context) {
        return const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        );
      },
    );
  }
}
