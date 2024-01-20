import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RetryEvent {
  final Key key;
  final Object event;

  RetryEvent({
    required this.key,
    required this.event,
  });
}

class EventBus {
  static final EventBus _singleton = EventBus._internal();

  factory EventBus() {
    return _singleton;
  }

  List<BaseBloc> _blocs = [];

  List<Broadcast> _broadcasts = [];

  List<RetryEvent> _retryEvents = [];

  EventBus._internal() {
    _blocs = [];
    _broadcasts = [];
    _retryEvents = [];
  }

  T addBloc<T extends BaseBloc>(Key key, T bloc) {
    log.trace('adding $bloc to EventBus with key $key');
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0 && _blocs[found] is T) {
      log.trace('$bloc already exists in EventBus with key $key');
      return _blocs[found] as T;
    }

    try {
      log.trace('$bloc with key $key is added to EventBus');
      _blocs.add(bloc);
      if (bloc.subscribes().isNotEmpty) {
        _broadcasts.addAll(bloc.subscribes());
      }
      _retryEvent<T>(key);
      log.trace(_blocs);
      return bloc;
    } catch (e) {
      log.error('Error in new instance of bloc $key: $e');
    }
    throw Exception('Something went wrong in creating bloc with key $key');
  }

  T? blocFromKey<T extends BaseBloc>(Key key) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0 && _blocs[found] is T) {
      return _blocs[found] as T;
    }
    return null;
  }

  void event<T extends BaseBloc>(Key key, Object event,
      {bool retryLater = false, Duration? delay}) {
    try {
      final found = _blocs.indexWhere((b) => b.key == key);
      if (found >= 0 && _blocs[found] is T) {
        if (delay != null) {
          Future.delayed(delay, () {
            _blocs[found].add(event);
          });
        } else {
          _blocs[found].add(event);
        }
      } else {
        if (retryLater) {
          _retryEvents.add(RetryEvent(key: key, event: event));
        }
      }
    } catch (e) {
      log.error('Call bloc event error: $e');
    }
  }

  void broadcast(String event, {Map params = const {}}) {
    for (final b in _broadcasts) {
      if (b.event == event) {
        b.onNext(params);
      }
    }
  }

  void unsubscribes(Key blocKey) {
    _broadcasts.removeWhere((b) => b.blocKey == blocKey);
  }

  void unHandle(Key blocKey) {
    _blocs.removeWhere((b) {
      return b.key == blocKey || b.closeWithBlocKey == blocKey;
    });
  }

  void _retryEvent<T extends BaseBloc>(Key key) {
    for (var i = 0; i < _retryEvents.length; i++) {
      final retry = _retryEvents[i];
      if (retry.key == key) {
        event<T>(retry.key, retry.event);
        _retryEvents.removeAt(i);
        break;
      }
    }
  }

  void cleanUp({Key? parentKey}) {
    final removedKeys = <Key>[];
    final closeKey = parentKey ?? const ValueKey('none_dispose_bloc');
    _blocs.removeWhere((b) {
      if (b.closeWithBlocKey == closeKey) {
        removedKeys.add(b.key);
        return true;
      }
      return false;
    });

    _broadcasts.removeWhere((b) {
      return removedKeys.contains(b.blocKey);
    });
  }
}
