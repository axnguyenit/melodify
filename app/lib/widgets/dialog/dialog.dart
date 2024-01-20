import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import 'base_dialog.dart';
import 'confirmation.dart';
import 'x_alert_dialog.dart';

class XDialog {
  final BuildContext context;

  XDialog.of(this.context);

  BaseXDialog confirmation({
    Key? key,
    required String title,
    required String message,
    String? okTitle,
    String? cancelTitle,
    AppIcon? icon,
  }) {
    return BaseXDialog(
      key: key,
      context: context,
      child: Confirmation(
        title: title,
        message: message,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
        icon: icon,
      ),
    );
  }

  BaseXDialog alert({
    Key? key,
    required String title,
    required String message,
    String? okTitle,
    AppIcon? icon,
  }) {
    return BaseXDialog(
      key: key,
      context: context,
      child: XAlertDialog(
        title: title,
        message: message,
        okTitle: okTitle,
        icon: icon,
      ),
    );
  }

  BaseXDialog open({Key? key, required Widget widget}) {
    return BaseXDialog(
      key: key,
      context: context,
      child: widget,
    );
  }
}
