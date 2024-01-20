import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class XTextFieldStory extends Story {
  XTextFieldStory({super.key});

  @override
  WidgetMap storyContent() {
    return WidgetMap(
      title: 'Text Field',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            XTextField(
              placeholder: 'Email',
              onFieldSubmitted: print,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: context.iconColor,
                size: 20,
              ),
            ),
            spacer,
            XTextField(
              label: 'Email',
              placeholder: 'Email',
              onFieldSubmitted: print,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: context.iconColor,
                size: 20,
              ),
            ),
            spacer,
            const XTextField(
              placeholder: 'Username',
              onFieldSubmitted: print,
            ),
            spacer,
            const PasswordField(
              placeholder: 'Please enter password',
              onFieldSubmitted: print,
            ),
            spacer,
            const PasswordField(
              label: 'Password',
              placeholder: 'Please enter password',
              onFieldSubmitted: print,
            ),
            spacer,
            const XTextField(
              enabled: false,
              initialValue: 'Disabled text field',
            ),
            spacer,
            const XTextField(
              enabled: false,
              label: 'Disabled',
              initialValue: 'Disabled text field',
            ),
            spacer,
            const XTextField(
              readOnly: true,
              initialValue: 'Readonly text field',
            ),
            spacer,
            const XTextField(
              readOnly: true,
              label: 'Readonly',
              initialValue: 'Readonly text field',
            ),
          ],
        ),
      ),
    );
  }
}
