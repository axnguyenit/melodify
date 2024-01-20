import 'package:flutter/material.dart';

import 'localization.dart';

extension LocalizationContextExtension on BuildContext {
  String translate(
    String key, {
    String suffix = '',
    List<dynamic> params = const [],
    bool checkNumberParams = false,
  }) {
    return S.of(this).translate(
          key,
          suffix: suffix,
          params: params,
          checkNumberParams: checkNumberParams,
        );
  }
}
