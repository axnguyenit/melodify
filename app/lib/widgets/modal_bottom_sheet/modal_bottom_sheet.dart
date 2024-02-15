import 'package:flutter/material.dart';

import 'base_modal_bottom_sheet.dart';

class ModalBottomSheet {
  static BaseModalBottomSheet open({
    Key? key,
    required BuildContext context,
    required Widget child,
  }) {
    return BaseModalBottomSheet(
      key: key,
      context: context,
      child: child,
    );
  }
}
