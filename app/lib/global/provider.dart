// import 'dart:ui';
//
// import 'package:devicelocale/devicelocale.dart';
//
// class Provider {
//   static final Provider _singleton = Provider._internal();
//
//   factory Provider() {
//     return _singleton;
//   }
//
//   Locale? _deviceLocale;
//
//   Provider._internal();
//
//   Locale get deviceLocale => _deviceLocale ?? const Locale('en');
//
//   Future<void> initialize() async {
//     final locale = await Devicelocale.currentLocale ?? 'en';
//     _deviceLocale = Locale(locale);
//   }
// }
