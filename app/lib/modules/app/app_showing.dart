import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

import 'app_loading.dart';
import 'lost_connection/lost_connection.dart';

class AppShowing extends StatefulWidget {
  final Widget child;

  const AppShowing({
    super.key,
    required this.child,
  });

  @override
  State<AppShowing> createState() => _AppShowingState();
}

class _AppShowingState extends State<AppShowing> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoadingBloc, LoadingState>(
          listener: (_, state) {},
        ),
        BlocListener<SessionBloc, SessionState>(
          listener: (_, state) {
            log.info(state);
            if (state is SessionSignOutSuccess || state is SessionLoadFailure) {
              Routing().pushNamedAndRemoveUntil(Routes.signIn);
            } else if (state is SessionSignInSuccess) {
              Routing().pushNamedAndRemoveUntil(Routes.dashboard);
            }
          },
        ),
        BlocListener<ToastBloc, ToastState>(
          listener: (context, state) {
            showToast(
              context,
              severity: state.severity,
              message: context.translate(
                state.message,
                params: state.params,
              ),
            );
          },
        ),
      ],
      child: Stack(
        children: [
          widget.child,
          const Loading(),
          const LostConnection(),
        ],
      ),
    );
  }
}
