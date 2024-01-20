import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:core/core.dart';

class AppInitializer {
  AppInitializer(this._appConfig);

  final BaseConfig _appConfig;

  Future<void> initialize() async {
    await DataConfig().initialize();
    await DomainConfig().initialize();
    await _appConfig.initialize();
  }
}
