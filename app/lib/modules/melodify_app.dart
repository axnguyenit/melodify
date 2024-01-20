import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/theme/theme.dart';
import 'package:resources/resources.dart';

import 'app/app_showing.dart';
import 'routes.dart';

class MelodifyApp extends StatefulWidget {
  const MelodifyApp({super.key});

  @override
  State<MelodifyApp> createState() => _MelodifyAppState();
}

class _MelodifyAppState extends State<MelodifyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionBloc>(create: (_) => di.bloc<SessionBloc>()),
        BlocProvider<ConnectivityBloc>(
            create: (_) => di.bloc<ConnectivityBloc>()),
        BlocProvider<LoadingBloc>(create: (_) => di.bloc<LoadingBloc>()),
        BlocProvider<LanguageBloc>(create: (_) => di.bloc<LanguageBloc>()),
        BlocProvider<ToastBloc>(create: (_) => di.bloc<ToastBloc>()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (_, current) =>
            current is LanguageInitial || current is LanguageUpdateSuccess,
        builder: (_, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Melodify',
            restorationScopeId: 'melodify',
            themeMode: ThemeMode.dark,
            theme: LightTheme().build(context),
            darkTheme: DarkTheme().build(context),
            locale: state.locale,
            supportedLocales: state.supportedLocales,
            localizationsDelegates: const [
              SLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorKey: Routing().navigatorKey,
            initialRoute: Routes.splash,
            navigatorObservers: [AppRouteObserver()],
            onGenerateRoute: Routes.generateRoute,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return AppShowing(child: child!);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
