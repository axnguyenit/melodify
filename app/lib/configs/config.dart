import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  factory Config() {
    return _singleton;
  }

  Config._internal();

  static final Config _singleton = Config._internal();

  String get supportedLanguages => dotenv.get('SUPPORTED_LANGUAGES');

  String get primaryLanguage => dotenv.get('PRIMARY_LANGUAGE');

  String get secondaryLanguage => dotenv.get('SECONDARY_LANGUAGE');
}
