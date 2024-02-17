import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

final data = <String>['Option 1', 'Option 2'];

// ignore: must_be_immutable
class DropdownStory extends Story {
  DropdownStory({super.key});

  @override
  WidgetMap storyContent() {
    Function? renderFunction;
    String? selectedValue;

    return WidgetMap(
      title: 'Dropdown',
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: StatefulStory(
            builder: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  XDropdown<String>(
                    items: data,
                    label: 'Select',
                    selectedValue: selectedValue,
                    itemBuilder: (BuildContext context, String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item),
                      );
                    },
                    onSelected: (value) {
                      selectedValue = value;
                      renderFunction!();
                    },
                  ),
                  const SizedBox(height: 24),
                  XDropdown<String>(
                    items: data,
                    selectedValue: selectedValue,
                    borderRadius: BorderRadius.circular(24),
                    itemBuilder: (BuildContext context, String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item),
                      );
                    },
                    onSelected: (value) {
                      selectedValue = value;
                      renderFunction!();
                    },
                  ),
                  const SizedBox(height: 24),
                  XDropdown<String>(
                    items: data,
                    selectedValue: selectedValue,
                    itemBuilder: (BuildContext context, String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: XStatus(
                          status: XStatusType.positive,
                          label: item,
                        ),
                      );
                    },
                    onSelected: (value) {
                      selectedValue = value;
                      renderFunction!();
                    },
                  ),
                  const SizedBox(height: 24),
                  XDropdown<String>(
                    items: data,
                    selectedValue: selectedValue,
                    itemBuilder: (BuildContext context, String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item),
                      );
                    },
                    onSelected: (value) {
                      selectedValue = value;
                      renderFunction!();
                    },
                  ),
                  const Spacer(),
                  XDropdown<String>(
                    items: data,
                    selectedValue: selectedValue,
                    itemBuilder: (BuildContext context, String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item),
                      );
                    },
                    onSelected: (value) {
                      selectedValue = value;
                      renderFunction!();
                    },
                  ),
                ],
              );
            },
            renderFunction: (render) {
              renderFunction = render;
            },
          ),
        );
      },
    );
  }
}
