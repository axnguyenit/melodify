import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class StatusStory extends Story {
  StatusStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Status',
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: const Column(
            children: [
              Spacer(),
              XStatus(label: 'Default'),
              SizedBox(height: 24),
              XStatus(label: 'Success', status: XStatusType.positive),
              SizedBox(height: 24),
              XStatus(label: 'Pending', status: XStatusType.pending),
              SizedBox(height: 24),
              XStatus(label: 'Failed', status: XStatusType.negative),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}
