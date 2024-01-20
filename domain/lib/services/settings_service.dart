import 'dart:ui';

abstract class SettingsService {
  Locale getCurrentLocale();

  List<Locale> getSupportedLocales();

  Future<void> setCurrentLocaleLanguageCode(String code);
}
