import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

typedef CheckingInternet = Future<List<InternetAddress>> Function(String host,
    {InternetAddressType type});

@LazySingleton()
class ConnectivityBloc extends BaseBloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  final String _internetCheckingHost;
  late final StreamSubscription<ConnectivityResult> subscription;
  final CheckingInternet _internetCheckingFunction;

  ConnectivityBloc()
      : _connectivity = Connectivity(),
        _internetCheckingHost = 'www.google.com',
        _internetCheckingFunction = InternetAddress.lookup,
        super(Keys.Blocs.connectivity, const ConnectivityInitial()) {
    subscription = _connectivity.onConnectivityChanged.listen((result) async {
      log.info('CONNECTION RESULT ──> $result');
      final isConnected = await _checkConnection();

      if (isConnected != state.isConnected) {
        add(ConnectivityChanged(isConnected));
      }
    });

    on<ConnectivityChecked>(_onConnectivityChecked);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await _internetCheckingFunction(_internetCheckingHost);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      log.error(e);
      return false;
    }
  }

  Future<void> _onConnectivityChecked(
      ConnectivityChecked event, Emitter<ConnectivityState> emit) async {
    emit(ConnectivityCheckInProgress(state.isConnected));

    final isConnected = await _checkConnection();
    if (isConnected != state.isConnected) {
      emit(ConnectivityUpdateSuccess(isConnected));
    }
  }

  Future<void> _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) async {
    emit(ConnectivityUpdateSuccess(event.isConnected));
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    await super.close();
  }
}
