import 'package:flutter/material.dart';

import 'auth/sign_in/sign_in_screen.dart';
import 'auth/sign_up/profile_creation_screen.dart';
import 'auth/sign_up/sign_up_screen.dart';
import 'auth/sign_up/sms_verification_screen.dart';
import 'dashboard/dashboard.dart';
import 'error/error_screen.dart';
import 'splash/splash_screen.dart';
import 'search/search_screen.dart';
import 'player/player_screen.dart';

enum RoutingAnimation {
  fade,
  scale,
  // rotate,
  slideRightToLeft,
  slideBottomToTop
}

class Routes {
  static final _singleton = Routes._internal();

  factory Routes() => _singleton;

  Routes._internal();

  static const splash = '/splash';
  static const dashboard = '/dashboard';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const smsVerification = '/sms-verification';
  static const profileCreation = '/profile-creation';
  static const search = '/search';
  static const player = '/player';

  static Route generateRoute(RouteSettings settings) {
    final RouteSettings(:name, :arguments) = settings;

    return switch (name) {
      splash => _pageBuilder(
          settings: settings,
          builder: () => const SplashScreen(),
          routingAnimation: RoutingAnimation.fade,
        ),
      dashboard => _pageBuilder(
          settings: settings,
          builder: () => const DashboardScreen(),
          routingAnimation: RoutingAnimation.fade,
        ),
      signIn => _pageBuilder(
          settings: settings,
          builder: () => const SignInScreen(),
          routingAnimation: RoutingAnimation.slideBottomToTop,
        ),
      signUp => _pageBuilder(
          settings: settings,
          builder: () => const SignUpScreen(),
        ),
      smsVerification => _pageBuilder(
          settings: settings,
          builder: () {
            final map = arguments as Map<String, dynamic>;
            final phone = map['phone'] as String;
            final verificationId = map['verificationId'] as String;

            return SmsVerificationScreen(
              phone: phone,
              verificationId: verificationId,
            );
          }),
      profileCreation => _pageBuilder(
          settings: settings,
          builder: () {
            final map = arguments as Map<String, dynamic>;
            final phone = map['phone'] as String;

            return ProfileCreationScreen(
              phone: phone,
            );
          }),
      search => _pageBuilder(
          settings: settings,
          builder: () => const SearchScreen(),
        ),
      player => _pageBuilder(
          settings: settings,
          opaque: false,
          routingAnimation: RoutingAnimation.slideBottomToTop,
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          builder: () => const PlayerScreen(),
        ),

      // bool isShow = false;
      // if (arguments != null) {
      //   final map = arguments as Map<String, dynamic>;
      //   isShow = map['isShow'] as bool? ?? false;
      // }

      _ => MaterialPageRoute(builder: (context) => const ErrorScreen()),
    };
  }

  static Route<T> _pageBuilder<T>({
    required RouteSettings settings,
    required Widget Function() builder,
    RoutingAnimation? routingAnimation,
    bool opaque = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    return switch (routingAnimation) {
      RoutingAnimation.fade => PageRouteBuilder(
          opaque: opaque,
          settings: settings,
          pageBuilder: (_, __, ___) => builder(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: transitionDuration,
        ),

      // case RoutingAnimation.rotate:
      //   return PageRouteBuilder(
      //     opaque => opaque,
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => child,
      //     transitionsBuilder: (_, animation, __, child) {
      //       return RotationTransition(
      //         turns: ReverseAnimation(animation),
      //         child: child,
      //       );
      //     },
      //     transitionDuration: const Duration(milliseconds: 500),
      //   );

      RoutingAnimation.scale => PageRouteBuilder(
          opaque: opaque,
          settings: settings,
          pageBuilder: (_, __, ___) => builder(),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          transitionDuration: transitionDuration,
        ),
      RoutingAnimation.slideRightToLeft => PageRouteBuilder(
          opaque: opaque,

          /// Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          settings: settings,
          pageBuilder: (_, __, ___) => builder(),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: transitionDuration,
        ),
      RoutingAnimation.slideBottomToTop => PageRouteBuilder(
          opaque: opaque,
          settings: settings,
          pageBuilder: (_, __, ___) => builder(),
          transitionsBuilder: (_, animation, __, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: transitionDuration,
          reverseTransitionDuration: reverseTransitionDuration,
        ),
      _ => PageRouteBuilder(
          opaque: opaque,
          settings: settings,
          pageBuilder: (_, __, ___) => builder(),
        ),
    };
  }
}
