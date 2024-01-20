import 'package:flutter/material.dart';
import 'package:melodify/theme/theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

void main() {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: LightTheme().build(context),
          darkTheme: DarkTheme().build(context),
          supportedLocales: const [Locale('en')],
          home: Storybook(
            [
              TextStory(),
              ButtonStory(),
              IconButtonStory(),
              XTextFieldStory(),
              ImageNetworkStory(),
              AvatarStory(),
              AvatarGroupStory(),
              PopupDrawerStory(),
              DebounceStory(),
              DropdownStory(),
              StatusStory(),
              FormValidationStory(),
              AlertStory(),
              ToastStory(),
            ],
          ),
        );
      },
    ),
  );
}
