import 'package:flutter/material.dart';

// Widget _defaultTransitionsBuilder(
//   BuildContext context,
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
//   Widget child,
// ) {
//   return child;
// }

class Routing {
  static final Routing _singleton = Routing._internal();

  String? _currentPath;

  factory Routing() {
    return _singleton;
  }

  Routing._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigatorState? get navigator => _navigatorKey.currentState;

  BuildContext get context => _navigatorKey.currentContext!;

  // ignore: unnecessary_getters_setters
  String? get currentPath => _currentPath;

  set currentPath(String? path) => _currentPath = path;

  bool get canPop => Navigator.of(context).canPop();

  void pushNamed(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  // void push(
  //   Widget screen, {
  //   RouteTransitionsBuilder transitionsBuilder = _defaultTransitionsBuilder,
  //   Duration transitionDuration = const Duration(milliseconds: 300),
  // }) {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       opaque: false,
  //       pageBuilder: (_, __, ___) => screen,
  //       transitionsBuilder: transitionsBuilder,
  //       transitionDuration: transitionDuration,
  //     ),
  //   );
  // }

  // Future<void> replaceLastWithNamed(
  //   String routeName, {
  //   Map<String, dynamic>? arguments,
  // }) async {
  //   _routeTrace(routeName);
  //   final routes = List.of(
  //       ModalRoute.of(context)!.settings.arguments as List<Page<dynamic>>);
  //
  //   // ignore: cascade_invocations
  //   routes.removeLast();
  //   await Navigator.of(context)
  //       .popAndPushNamed(routeName, arguments: arguments);
  // }

  void pushReplacementNamed(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Use a RoutePredicate that returns false every time
  /// (Route<dynamic> route) => false.
  /// In this case, it removes all routes except newly submitted [routeName].
  /// ────────────────────────────────────────────
  void pushNamedAndRemoveUntil(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void popUntil(String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  void pop<T extends Object>([T? result]) {
    Navigator.of(context).pop<T>(result);
  }
}
