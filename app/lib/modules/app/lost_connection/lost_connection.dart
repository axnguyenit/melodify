import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/mixins/mixins.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

part 'lost_connection_dialog.dart';

class LostConnection extends StatefulWidget {
  const LostConnection({super.key});

  @override
  State<LostConnection> createState() => _LostConnectionState();
}

class _LostConnectionState extends State<LostConnection> with StateMixin {
  bool _isPopupShowing = false;
  final _connectivityBloc = di.get<ConnectivityBloc>();
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();

    _appLifecycleListener = AppLifecycleListener(
      onInactive: () {
        log.warning('onInactive');
      },
      onResume: () {
        log.warning('onResume');
        if (!_connectivityBloc.state.isConnected && !_isPopupShowing) {
          _showNoConnectionPopup();
        } else {
          _connectivityChecked();
        }
      },
      onHide: () {
        log.warning('onHide');
      },
      onShow: () {
        log.warning('onShow');
      },
      onRestart: () {
        log.warning('onRestart');
      },
      onPause: () {
        log.warning('onPause');
      },
      onDetach: () {
        log.warning('onDetach');
      },
    );

    postFrame(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!_connectivityBloc.state.isConnected && !_isPopupShowing) {
        await _showNoConnectionPopup();
      }
    });
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();

    super.dispose();
  }

  void _connectivityChecked() {
    _connectivityBloc.add(ConnectivityChecked());
  }

  Future<void> _showNoConnectionPopup() async {
    _isPopupShowing = true;
    await XDialog.of(Routing().context)
        .open(
          widget: LostConnectionDialog(
            onCheckConnectionPressed: _connectivityChecked,
          ),
        )
        .show();
    _isPopupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityBloc, ConnectivityState>(
      listenWhen: (_, current) => current is ConnectivityUpdateSuccess,
      listener: (_, state) async {
        if (!state.isConnected) {
          await _showNoConnectionPopup();
        } else {
          if (_isPopupShowing) {
            Routing().pop();
          }
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: !state.isConnected,
          child: Container(
            color: Colors.black12,
          ),
        );
      },
    );
  }
}
