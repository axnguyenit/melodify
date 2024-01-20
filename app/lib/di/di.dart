import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

@InjectableInit()
Future<void> configureDependencies() async => di.getIt.init();

final di = DI();

class DI {
  static final _singleton = DI._internal();
  final _getIt = GetIt.instance;

  GetIt get getIt => _getIt;

  EventBus get _eventBus => EventBus();

  factory DI() {
    return _singleton;
  }

  DI._internal();

  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return _getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  Future<T> getAsync<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return _getIt.getAsync<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  B bloc<B extends BaseBloc>({bool saveInstance = false}) {
    final bloc = get<B>();

    if (saveInstance) {
      _eventBus.addBloc<B>(bloc.key, bloc);
    }

    return bloc;
  }

  T? blocFromKey<T extends BaseBloc>(Key key) {
    return _eventBus.blocFromKey<T>(key);
  }

  void broadcast(String event, {Map params = const {}}) {
    return _eventBus.broadcast(event, params: params);
  }
}
