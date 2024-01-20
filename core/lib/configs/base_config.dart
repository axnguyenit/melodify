import 'package:async/async.dart';

abstract class BaseConfig {
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> config();

  Future<void> initialize() => _asyncMemoizer.runOnce(config);
}
