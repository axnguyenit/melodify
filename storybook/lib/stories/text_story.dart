import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore_for_file: avoid_print
// ignore: must_be_immutable
class TextStory extends Story {
  TextStory({super.key});

  @override
  WidgetMap storyContent() {
    const smallBoxSpace = SizedBox(height: 8);
    return WidgetMap(
      title: 'Text',
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            XText.displayLarge('Display Large'),
            smallBoxSpace,
            XText.displayMedium('Display Medium'),
            smallBoxSpace,
            XText.displaySmall('Display Small'),
            SizedBox(height: 24),
            XText.headlineLarge('Headline Large'),
            smallBoxSpace,
            XText.headlineMedium('Headline Medium'),
            smallBoxSpace,
            XText.headlineSmall('Headline Small'),
            SizedBox(height: 24),
            XText.titleLarge('Title Large'),
            smallBoxSpace,
            XText.titleMedium('Title Medium'),
            smallBoxSpace,
            XText.titleSmall('Title Small'),
            SizedBox(height: 24),
            XText.labelLarge('Label Large'),
            smallBoxSpace,
            XText.labelMedium('Label Medium'),
            smallBoxSpace,
            XText.labelSmall('Label Small'),
            SizedBox(height: 24),
            XText.bodyLarge('Body Large'),
            smallBoxSpace,
            XText.bodyMedium('Body Medium'),
            smallBoxSpace,
            XText.bodySmall('Body Small'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
