import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class AlertStory extends Story {
  AlertStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Alert',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Alert(
                message: 'This is a info alert',
                severity: AlertSeverity.info,
                action: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {},
                ),
              ),
              spacer,
              Alert(
                message: 'This is a success alert',
                severity: AlertSeverity.success,
                action: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {},
                ),
              ),
              spacer,
              const Alert(
                message: 'This is a warning alert',
                severity: AlertSeverity.warning,
              ),
              spacer,
              const Alert(
                message: 'This is a error alert',
                severity: AlertSeverity.error,
              ),
              spacer,
              spacer,

              /// Filled alert
              Alert(
                message: 'This is a info alert',
                severity: AlertSeverity.info,
                variant: AlertVariant.solid,
                action: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              spacer,
              Alert(
                message: 'This is a success alert',
                severity: AlertSeverity.success,
                variant: AlertVariant.solid,
                action: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              spacer,
              const Alert(
                message: 'This is a warning alert',
                severity: AlertSeverity.warning,
                variant: AlertVariant.solid,
              ),
              spacer,
              const Alert(
                message: 'This is a error alert',
                severity: AlertSeverity.error,
                variant: AlertVariant.solid,
              ),
              spacer,
            ],
          ),
        );
      },
    );
  }
}
