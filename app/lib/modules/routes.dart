import 'package:flutter/material.dart';

import 'auth/sign_in/sign_in_screen.dart';
import 'auth/sign_up/profile_creation_screen.dart';
import 'auth/sign_up/sign_up_screen.dart';
import 'auth/sign_up/sms_verification_screen.dart';
import 'error/error_screen.dart';
import 'home/home_screen.dart';
import 'splash/splash_screen.dart';

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

  static Route generateRoute(RouteSettings settings) {
    final RouteSettings(:name, :arguments) = settings;

    switch (name) {
      case splash:
        return _pageBuilder(
          settings: settings,
          child: const SplashScreen(),
          routingAnimation: RoutingAnimation.fade,
        );

      case dashboard:
        return _pageBuilder(
          settings: settings,
          child: const HomeScreen(),
          routingAnimation: RoutingAnimation.fade,
        );

      case signIn:
        return _pageBuilder(
          settings: settings,
          child: const SignInScreen(),
          routingAnimation: RoutingAnimation.slideBottomToTop,
        );

      case signUp:
        return _pageBuilder(
          settings: settings,
          child: const SignUpScreen(),
        );

      case smsVerification:
        final map = arguments as Map<String, dynamic>;
        final phone = map['phone'] as String;
        final verificationId = map['verificationId'] as String;

        return _pageBuilder(
          settings: settings,
          child: SmsVerificationScreen(
            phone: phone,
            verificationId: verificationId,
          ),
        );

      case profileCreation:
        final map = arguments as Map<String, dynamic>;
        final phone = map['phone'] as String;

        return _pageBuilder(
          settings: settings,
          child: ProfileCreationScreen(
            phone: phone,
          ),
        );

      // bool isShow = false;
      // if (arguments != null) {
      //   final map = arguments as Map<String, dynamic>;
      //   isShow = map['isShow'] as bool? ?? false;
      // }

      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }

  static Route<T> _pageBuilder<T>({
    required RouteSettings settings,
    required Widget child,
    RoutingAnimation? routingAnimation,
  }) {
    switch (routingAnimation) {
      case RoutingAnimation.fade:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
        );

      // case RoutingAnimation.rotate:
      //   return PageRouteBuilder(
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

      case RoutingAnimation.scale:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case RoutingAnimation.slideRightToLeft:
        return PageRouteBuilder(
          /// Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          settings: settings,
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case RoutingAnimation.slideBottomToTop:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      default:
        return MaterialPageRoute(settings: settings, builder: (_) => child);
    }
  }
}
