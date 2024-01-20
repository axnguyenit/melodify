import 'dart:math';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'string_extension.dart';

extension IntExtension on int {
  String toShortNumberString() {
    if (this < 10000) {
      if (this < 1000) {
        return toString();
      }
      var reverseString = toString().reverse();
      final int commaNumber = (reverseString.length - 1) ~/ 3;
      for (int i = 0; i < commaNumber; i++) {
        reverseString = reverseString.insert(',', at: (i + 1) * 3 + i);
      }
      return reverseString.reverse();
    }
    if (this < 10000000) {
      final value = this / 1000.0;
      if (value > 1000) {
        return sprintf('%0.1fk', [value]).insert(',', at: 1);
      }
      return sprintf('%0.1fk', [value]);
    }
    final value = this / 1000000.0;
    return sprintf('%0.1fm', [value]);
  }

  String toNumberString() {
    if (this < 1000) {
      return toString();
    }
    String reverseString = toString().reverse();
    final int commaNumber = (reverseString.length - 1) ~/ 3;
    for (int i = 0; i < commaNumber; i++) {
      reverseString = reverseString.insert(',', at: (i + 1) * 3 + i);
    }
    return reverseString.reverse();
  }

  String formatNumber({String locale = 'en'}) =>
      NumberFormat.decimalPattern(locale).format(this);

  String formatBytes({int decimals = 2}) {
    if (this <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    final i = (log(this) / log(1024)).floor();
    return '${(this / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  int get yearTo4Digits {
    if (this < 100 && this >= 0) {
      final now = DateTime.now();
      final String currentYear = now.year.toString();
      final String prefix = currentYear.substring(0, currentYear.length - 2);
      return int.parse('$prefix${toString().padLeft(2, '0')}');
    }

    return this;
  }
}
