import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  factory Config() {
    return _singleton;
  }

  Config._internal();

  static final Config _singleton = Config._internal();

  String get baseUrl => dotenv.get('BASE_URL');

  String get apiVersion => dotenv.get('API_VERSION');

  String get supportedLanguages => dotenv.get('SUPPORTED_LANGUAGES');

  String get primaryLanguage => dotenv.get('PRIMARY_LANGUAGE');

  String get secondaryLanguage => dotenv.get('SECONDARY_LANGUAGE');

  String get querySuggestionUrl => dotenv.get('QUERY_SUGGESTION_URL');

  String get youtubeMusicUrl => dotenv.get('YOUTUBE_MUSIC_URL');
}
