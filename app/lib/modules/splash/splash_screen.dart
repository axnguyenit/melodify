import 'package:flutter/material.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/widgets/loading/loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreenWithBloc<SplashScreen, SessionBloc> {
  @override
  void initState() {
    super.initState();

    postFrame(() async {
      final mediaQueryData = MediaQuery.of(context);
      await Future.delayed(const Duration(milliseconds: 1500));
      AppConstants.screenSize = mediaQueryData.size;
      AppConstants.statusBarHeight = mediaQueryData.viewPadding.top;
      bloc.add(const SessionLoaded());
    });
  }

  @override
  Widget get buildBody {
    return const XLoading();
  }
}
