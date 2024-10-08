// ignore_for_file: lines_longer_than_80_chars

// import 'package:crypto/crypto.dart';

extension StringExtension on String {
  String reverse() {
    return split('').reversed.join();
  }

  String insert(String string, {required int at}) {
    final comps = List<String>.from(split(''))..insert(at, string);
    return comps.join();
  }

  String excludePrefixURLIfNeeded() {
    if (!isURL()) {
      return this;
    }

    final uri = Uri.parse(this);
    return uri.path;
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String pathExtension() {
    final comps = split('.');
    if (comps.length > 1) {
      return comps.last;
    }
    return this;
  }

  String pathInsertBeforeExtension(String extra) {
    final comps = split('.');
    if (comps.length > 1) {
      return insert('_$extra', at: length - (comps.last.length + 1));
    }
    return '${this}_$extra';
  }

// String generateMd5() {
//   return md5.convert(utf8.encode(this)).toString();
// }
}

extension StringValidator on String {
  bool isURL() {
    const pattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  bool get isEmail {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  bool atLeast1Uppercase() {
    const pattern = r'^(?=.*[A-Z])';
    return contains(RegExp(pattern));
  }

  bool atLeast1Lowercase() {
    const pattern = r'^(?=.*[a-z])';
    return contains(RegExp(pattern));
  }

  bool atLeast1Number() {
    const pattern = r'^(?=.*[0-9])';
    return contains(RegExp(pattern));
  }

  bool isNumber() {
    return int.tryParse(this) != null;
  }

  bool get isPhone {
    return RegExp(r'^\+?[1-9]\d{6,14}$').hasMatch(this);
  }

  /// (?!.* ): does not contain white spaces
  /// (?=.*?[A-Z]) At least one uppercase letter
  /// (?=.*?[a-z]) At least one lowercase letter
  /// (?=.*?[0-9]) At least one digit (?=.*\d)
  /// (?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]) At least one special character
  /// {8,} Has minimum 8 characters in length
  bool get isStrongPassword {
    const pattern =
        r'^(?!.* )(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$';
    return RegExp(pattern).hasMatch(this);
  }
}

extension StringCheckerExtensions on String? {
  /// Returns `true` if this nullable char sequence is either `null` or empty.
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  /// Returns `false` if this nullable char sequence is either `null` or empty.
  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  /// Returns a progression that goes over the same range in the opposite direction with the same step.
  String reversed() {
    var res = '';
    for (int i = this!.length; i >= 0; --i) {
      res = this![i];
    }
    return res;
  }

  /// Returns the value of this number as an [int]
  int toInt() => int.parse(this!);

  /// Returns the value of this number as an [int] or null if can not be parsed.
  int? toIntOrNull() {
    if (this == null) {
      return null;
    }
    return int.tryParse(this!);
  }

  /// Returns the value of this number as an [double]
  double toDouble() => double.parse(this!);

  /// Returns the value of this number as an [double] or null if can not be parsed.
  double? toDoubleOrNull() {
    if (this == null) {
      return null;
    }
    return double.tryParse(this!);
  }

  /// Returns true if 'this' is "true", otherwise - false
  bool toBoolean() => this?.toLowerCase() == 'true';

  ///  Replaces part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String? replaceAfter(String delimiter, String replacement,
      [String? defaultValue]) {
    if (this == null) {
      return null;
    }
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isNullOrEmpty
            ? this
            : defaultValue
        : this!.replaceRange(index + 1, this!.length, replacement);
  }

  /// Replaces part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue!] which defaults to the original string.
  String? replaceBefore(String delimiter, String replacement,
      [String? defaultValue]) {
    if (this == null) {
      return null;
    }
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isNullOrEmpty
            ? this
            : defaultValue
        : this!.replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool Function(String element) predicate) =>
      this?.split('').any((s) => predicate(s)) ?? false;

  /// Returns last symbol of string or empty string if `this` is null or empty
  String get last {
    if (isNullOrEmpty) {
      return '';
    }
    return this![this!.length - 1];
  }

  /// Returns `true` if strings are equals without matching case
  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this?.toLowerCase() == other.toLowerCase());

  /// Returns `true` if string contains another without matching case
  bool containsIgnoreCase(String? other) {
    if (other == null) {
      return false;
    }
    return this?.toLowerCase().contains(other.toLowerCase()) ?? false;
  }

  /// Returns `true` if this more than 255 chars
  bool isMoreThan(int limit) {
    return this!.length > limit;
  }
}
