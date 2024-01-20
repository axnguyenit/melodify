import 'package:flutter/material.dart';
import 'package:melodify/theme/theme.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class ToastStory extends Story {
  ToastStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Toast',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              XButton(
                title: 'Info toast',
                color: Palette.information,
                onPressed: () {
                  showToast(
                    context,
                    message: 'This is a info toast \nThis is a info toast',
                    severity: AlertSeverity.info,
                  );
                },
              ),
              spacer,
              XButton(
                title: 'Success toast',
                color: Palette.positive,
                onPressed: () {
                  showToast(
                    context,
                    message: 'This is a success toast',
                    severity: AlertSeverity.success,
                  );
                },
              ),
              spacer,
              XButton(
                title: 'Warning toast',
                color: Palette.warning,
                onPressed: () {
                  showToast(
                    context,
                    message: 'This is a warning toast',
                    severity: AlertSeverity.warning,
                  );
                },
              ),
              spacer,
              XButton(
                title: 'Error toast',
                color: Palette.negative,
                onPressed: () {
                  showToast(
                    context,
                    message: 'This is a error toast',
                    severity: AlertSeverity.error,
                  );
                },
              ),
              spacer,
            ],
          ),
        );
      },
    );
  }
}
