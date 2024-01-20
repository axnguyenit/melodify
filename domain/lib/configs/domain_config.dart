import 'package:core/core.dart';
import 'package:domain/di/di.dart' as di;

class DomainConfig extends BaseConfig {
  factory DomainConfig() => _instance;

  DomainConfig._internal();

  static final DomainConfig _instance = DomainConfig._internal();

  @override
  Future<void> config() async {
    await di.configureDependencies();
  }
}
