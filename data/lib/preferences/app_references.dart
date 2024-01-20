import 'package:data/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class AppPreferences {
  AppPreferences(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String? get accessToken {
    return _sharedPreferences.getString(SharedPreferenceKeys.accessToken);
  }

  String? get profileToken {
    return _sharedPreferences.getString(SharedPreferenceKeys.profileToken);
  }
}
