import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text('Display Large', style: context.displayLarge),
            smallBoxSpace,
            Text('Display Medium', style: context.displayMedium),
            smallBoxSpace,
            Text('Display Small', style: context.displaySmall),
            const SizedBox(height: 24),
            Text('Headline Large', style: context.headlineLarge),
            smallBoxSpace,
            Text('Headline Medium', style: context.headlineMedium),
            smallBoxSpace,
            Text('Headline Small', style: context.headlineSmall),
            const SizedBox(height: 24),
            Text('Title Large', style: context.titleLarge),
            smallBoxSpace,
            Text('Title Medium', style: context.titleMedium),
            smallBoxSpace,
            Text('Title Small', style: context.titleSmall),
            const SizedBox(height: 24),
            Text('Label Large', style: context.labelLarge),
            smallBoxSpace,
            Text('Label Medium', style: context.labelMedium),
            smallBoxSpace,
            Text('Label Small', style: context.labelSmall),
            const SizedBox(height: 24),
            Text('Body Large', style: context.bodyLarge),
            smallBoxSpace,
            Text('Body Medium', style: context.bodyMedium),
            smallBoxSpace,
            Text('Body Small', style: context.bodySmall),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
