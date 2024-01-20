import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class ButtonStory extends Story {
  ButtonStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Button',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            children: [
              const XButton(
                title: 'DEFAULT',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton(
                title: 'DEFAULT SMALL',
                size: XButtonSize.small,
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton.text(
                title: 'TEXT',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton.outlined(
                title: 'OUTLINED',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton(
                title: 'SOLID',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton(title: 'DISABLED SOLID'),
              const SizedBox(height: 24),
              const XButton.outlined(title: 'DISABLED OUTLINE'),
              const SizedBox(height: 24),
              const XButton.text(title: 'DISABLED TEXT'),
              const SizedBox(height: 24),
              const XButton.negative(
                title: 'NEGATIVE - TEXT',
                variant: XButtonVariant.text,
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton.negative(
                title: 'NEGATIVE - OUTLINED',
                variant: XButtonVariant.outline,
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton.negative(
                title: 'NEGATIVE - SOLID',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton.text(
                loading: true,
                title: 'TEXT - LOADING',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              const XButton(
                loading: true,
                title: 'SOLID - LOADING',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              XButton.negative(
                variant: XButtonVariant.outline,
                prefixIcon: Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: context.errorColor,
                ),
                title: 'BACK',
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              XButton(
                prefixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.cardColor,
                ),
                title: 'Button',
                suffixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.cardColor,
                ),
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              XButton.outlined(
                prefixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.primaryColor,
                ),
                title: 'Button',
                suffixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.primaryColor,
                ),
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              XButton.text(
                prefixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.primaryColor,
                ),
                title: 'Button',
                suffixIcon: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: context.primaryColor,
                ),
                onPressed: noop,
              ),
              const SizedBox(height: 24),
              XLinkButton(
                title: 'LINK BUTTON',
                onPressed: () {
                  debugPrint('LINK BUTTON');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
