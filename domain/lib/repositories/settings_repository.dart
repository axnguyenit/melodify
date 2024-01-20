import 'dart:ui';

abstract class SettingsRepository {
  Locale? getCurrentLocale();

  Future<void> setCurrentLocaleLanguageCode(String code);
}
