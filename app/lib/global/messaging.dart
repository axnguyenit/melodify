import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/models/models.dart';

@LazySingleton()
class Messaging {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final List<String> subscribedTopics = <String>['topic_all_users'];

  Future<void> addTopics(List<String> topics) async {
    final addingTopics = <String>[];
    for (final topic in topics) {
      if (!subscribedTopics.contains(topic) && topic.isNotEmpty) {
        addingTopics.add(topic);
      }
    }
    if (addingTopics.isEmpty) return;

    await Future.wait(
      addingTopics.map(_firebaseMessaging.subscribeToTopic).toList(),
    );
    subscribedTopics.addAll(addingTopics);
  }

  Future<void> unsubscribeAllTopics() async {
    await Future.wait(
      subscribedTopics.map(_firebaseMessaging.unsubscribeFromTopic).toList(),
    );
    subscribedTopics.clear();
  }

  Future<void> _onMessage(RemoteMessage message) async {
    log
      ..trace('Foreground message')
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

  void _onMessageOpenedApp(RemoteMessage message) {
    log
      ..trace('Opened App message')
      ..logMap(message.toMap());
    di.get<LocalNotification>().onMessageOpenedApp('path');
  }

  Future<void> initialize() async {
    try {
      await _requestPermission();
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );

      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
      log.trace('FCM Token --> ${await getDeviceToken}');
      // final message = await FirebaseMessaging.instance.getInitialMessage();
      // if (message == null) return;
      // log
      //   ..trace('Initial Message')
      //   ..logMap(message.toMap());
      // di.get<LocalNotification>().onMessageOpenedApp('payload');
    } catch (e) {
      log.trace('Register Device Error --> $e');
    }
  }

  Future<String?> get getDeviceToken => _firebaseMessaging.getToken();

  Future<void> get deleteDeviceToken async => _firebaseMessaging.deleteToken();

  Future<void> subscribes({List<String> topics = const []}) async {
    try {
      if (topics.isNotEmpty) {
        subscribedTopics.addAll(topics);
      }
      if (subscribedTopics.isNotEmpty) {
        await Future.wait(
          subscribedTopics.map(_firebaseMessaging.subscribeToTopic).toList(),
        );
      }
    } catch (e) {
      log.trace('Subscribe To Topic Error --> $e');
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    log.trace('User granted permission --> ${settings.authorizationStatus}');
  }
}
