import 'dart:ui';

import 'package:data/dao/dao.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao _settingsDao;

  SettingsRepositoryImpl(SettingsDao settingsDao) : _settingsDao = settingsDao;

  @override
  Locale? getCurrentLocale() {
    final languageCode = _settingsDao.getCurrentLocaleLanguageCode();

    return languageCode != null ? Locale(languageCode) : null;
  }

  @override
  Future<void> setCurrentLocaleLanguageCode(String code) async {
    await _settingsDao.setCurrentLocaleLanguageCode(code);
  }
}
