import 'package:core/core.dart';

bool hasDateExpired(int month, int year) {
  return isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
  // It has not expired if both the year and date has not passed
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

List<int> getExpiryDate(String value) {
  final split = value.split(RegExp(r'(/)'));
  return [int.parse(split[0]), int.parse(split[1])];
}

bool hasMonthPassed(int year, int month) {
  final now = DateTime.now();
  // The month has passed if:
  // 1. The year is in the past. In that case, we just assume that the month
  // has passed
  // 2. Card's month (plus another month) is more than current month.
  return hasYearPassed(year) ||
      year.yearTo4Digits == now.year && (month < now.month + 1);
}

bool hasYearPassed(int year) {
  final int fourDigitsYear = year.yearTo4Digits;
  final now = DateTime.now();
  // The year has passed if the year we are currently is more than card's
  // year
  return fourDigitsYear < now.year;
}

class ValidationRule<T> {
  final String message;
  final bool Function(String? value) validate;

  ValidationRule({
    required this.message,
    required this.validate,
  });

  factory ValidationRule.required(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        return value.trim().isNotEmpty;
      },
    );
  }

  factory ValidationRule.email(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        return value.isEmail;
      },
    );
  }

  factory ValidationRule.number(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        return int.tryParse(value) != null;
      },
    );
  }

  factory ValidationRule.min(int min, String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) {
          return false;
        } else if (T == int) {
          final intValue = int.tryParse(value);
          if (intValue == null) return false;
          return intValue >= min;
        } else if (T == String) {
          return value.trim().length >= min;
        } else {
          throw Exception('Invalid type');
        }
      },
    );
  }

  factory ValidationRule.max(int max, String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) {
          return false;
        } else if (T == int) {
          final intValue = int.tryParse(value);
          if (intValue == null) return false;
          return intValue <= max;
        } else if (T == String) {
          return value.trim().length <= max;
        } else {
          throw Exception('Invalid type');
        }
      },
    );
  }

  factory ValidationRule.phone(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        return value.isPhone;
      },
    );
  }

  factory ValidationRule.isCVC(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        if (value.length < 3 || value.length > 4) return false;

        return true;
      },
    );
  }

  factory ValidationRule.isCardExpiration(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;

        int month, year;
        if (value.contains(RegExp(r'(/)'))) {
          final split = value.split(RegExp(r'(/)'));
          month = int.parse(split.first);
          year = int.parse(split.last);
        } else {
          month = int.parse(value.substring(0, value.length));
          year = -1; // Lets use an invalid year intentionally
        }

        // A valid month is between 1 (January) and 12 (December)
        if (month < 1 || month > 12) return false;

        final fourDigitsYear = year.yearTo4Digits;
        // We are assuming a valid should be between 1 and 2099.
        // Note that, it's valid doesn't mean that it has not expired.
        if (fourDigitsYear < 1 || fourDigitsYear > 2099) return false;
        if (!hasDateExpired(month, year)) return false;

        return true;
      },
    );
  }

  factory ValidationRule.password(String message) {
    return ValidationRule(
      message: message,
      validate: (String? value) {
        if (value == null) return false;
        return value.isStrongPassword;
      },
    );
  }
}

extension ValidationRuleExtension on List<ValidationRule> {
  String? validate(String? value) {
    for (final rule in this) {
      if (!rule.validate(value)) {
        return rule.message;
      }
    }

    return null;
  }
}
