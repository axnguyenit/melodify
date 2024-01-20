import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:initializer/initializer.dart';
import 'package:melodify/configs/configs.dart';

import 'modules/melodify_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppInitializer(AppConfig()).initialize();

  runZonedGuarded(_runApp, _reportError);
}

void _runApp() {
  runApp(const MelodifyApp());
}

void _reportError(Object error, StackTrace stackTrace) {
  log
    ..error(error)
    ..trace(stackTrace);

  // Report error to Firebase Crashlytics here
}
