import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> {
  final Key key;
  final Key? closeWithBlocKey;

  BaseBloc(
    this.key,
    S initialState, {
    this.closeWithBlocKey,
  }) : super(initialState) {
    log.trace('New bloc with key $key is created');
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null &&
        closeWithBlocKey != const Key('force_to_dispose_bloc')) {
      return;
    }

    log.trace('Bloc with key $key is disposed');
    EventBus().unsubscribes(key);
    EventBus().unHandle(key);
    otherBlocsUnSubscription();

    await super.close();
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnSubscription() {}

  List<Broadcast> subscribes() {
    return <Broadcast>[];
  }

  void addLater(E event, {Duration after = const Duration(seconds: 1)}) {
    Future.delayed(after, () => add(event));
  }
}
