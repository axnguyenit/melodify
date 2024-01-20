import 'package:core/core.dart';
import 'package:data/di/di.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataConfig extends BaseConfig {
  factory DataConfig() => _instance;

  DataConfig._internal();

  static final DataConfig _instance = DataConfig._internal();

  @override
  Future<void> config() async {
    await dotenv.load();
    await di.configureDependencies();
  }
}
