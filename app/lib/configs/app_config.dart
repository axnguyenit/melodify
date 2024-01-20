import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/models/models.dart';

// @pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  log
    ..trace('Background message')
    ..logMap(message.toMap());
  final RemoteMessage(:notification) = message;
  if (notification == null) return;

  final RemoteNotification(:hashCode, :title, :body) = notification;
  final notificationData = NotificationData(
    id: hashCode,
    title: title,
    body: body,
  );
  await di.get<LocalNotification>().showNotification(notificationData);
}

// ════════════════════════════════════════════

class AppConfig extends BaseConfig {
  factory AppConfig() => _instance;

  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  @override
  Future<void> config() async {
    await dotenv.load();
    await configureDependencies();
    await di.get<LocalNotification>().initialize();
    await di.get<Messaging>().initialize();
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    Bloc.observer = SimpleBlocObserver();
  }
}
