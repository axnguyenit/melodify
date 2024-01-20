import 'dart:ui';

import 'package:data/configs/config.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsService)
class SettingsServiceImpl implements SettingsService {
  final SettingsRepository _settingsRepository;

  SettingsServiceImpl(this._settingsRepository);

  @override
  Locale getCurrentLocale() {
    var locale = _settingsRepository.getCurrentLocale();
    if (locale == null) {
      const systemLocale = Locale('en');
      locale = systemLocale.languageCode == Config().primaryLanguage
          ? systemLocale
          : Locale(Config().secondaryLanguage);
    }
    return locale;
  }

  @override
  List<Locale> getSupportedLocales() {
    return Config().supportedLanguages.split(',').map(Locale.new).toList();
  }

  @override
  Future<void> setCurrentLocaleLanguageCode(String code) async {
    await _settingsRepository.setCurrentLocaleLanguageCode(code);
  }
}
