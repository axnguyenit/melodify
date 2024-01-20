abstract class SettingsDao {
  String? getCurrentLocaleLanguageCode();

  Future<void> setCurrentLocaleLanguageCode(String code);
}
