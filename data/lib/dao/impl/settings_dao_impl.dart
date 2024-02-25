import 'package:data/constants/constants.dart';
import 'package:data/dao/base_dao.dart';
import 'package:data/dao/dao.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsDao)
class SettingsDaoImpl extends BaseDao implements SettingsDao {
  SettingsDaoImpl({required super.preferences});

  @override
  String? getCurrentLocaleLanguageCode() {
    return getString(SharedPreferenceKeys.localCode);
  }

  @override
  Future<void> setCurrentLocaleLanguageCode(String code) async {
    await saveString(code, SharedPreferenceKeys.localCode);
  }
}
