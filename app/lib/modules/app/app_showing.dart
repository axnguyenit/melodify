import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/models/extensions/extensions.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

import 'app_loading.dart';
// import 'lost_connection/lost_connection.dart';

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
            Routing().pushNamedAndRemoveUntil(Routes.dashboard);
            // if (state is SessionSignOutSuccess || state is SessionLoadFailure) {
            //   Routing().pushNamedAndRemoveUntil(Routes.signIn);
            // } else if (state is SessionSignInSuccess) {
            //   Routing().pushNamedAndRemoveUntil(Routes.dashboard);
            // }
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
        BlocListener<VideoDetailsBloc, VideoDetailsState>(
          listenWhen: (_, current) => current is VideoDetailsLoadSuccess,
          listener: (context, state) async {
            if (state is VideoDetailsLoadSuccess) {
              log.trace('PLAY MUSIC --> ${state.videoDetails?.title}');
              await di
                  .get<AppAudioHandler>()
                  .playMusic(state.videoDetails!.toMediaItem());
              // Routing().pushNamed(Routes.player);
            }
          },
        ),
      ],
      child: Stack(
        children: [
          widget.child,
          const Loading(),
          // const LostConnection(),
        ],
      ),
    );
  }
}
