import 'package:data/dao/base_dao.dart';
import 'package:data/dao/dao.dart';
import 'package:injectable/injectable.dart';

const currentLocaleLanguageCodeKey = 'key_current_locale_country_code';

@Injectable(as: SettingsDao)
class SettingsDaoImpl extends BaseDao implements SettingsDao {
  SettingsDaoImpl({required super.preferences});

  @override
  String? getCurrentLocaleLanguageCode() {
    final languageCode = getString(currentLocaleLanguageCodeKey);
    return languageCode;
  }

  @override
  Future<void> setCurrentLocaleLanguageCode(String code) async {
    await saveString(code, currentLocaleLanguageCodeKey);
  }
}
