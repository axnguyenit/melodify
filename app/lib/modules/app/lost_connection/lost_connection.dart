import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

part 'lost_connection_dialog.dart';

class LostConnection extends StatefulWidget {
  const LostConnection({super.key});

  @override
  State<LostConnection> createState() => _LostConnectionState();
}

class _LostConnectionState extends State<LostConnection>
    with WidgetsBindingObserver {
  bool _isPopupShowing = false;
  final connectivityBloc = di.get<ConnectivityBloc>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      if (!connectivityBloc.state.isConnected && !_isPopupShowing) {
        await _showNoConnectionPopup();
      }
    });
  }

  void _connectivityChecked() {
    connectivityBloc.add(ConnectivityChecked());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          if (!connectivityBloc.state.isConnected && !_isPopupShowing) {
            _showNoConnectionPopup();
          } else {
            _connectivityChecked();
          }
        }
        break;
      case AppLifecycleState.inactive:
        {}
        break;
      default:
    }
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
            Navigator.of(Routing().context).pop();
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
