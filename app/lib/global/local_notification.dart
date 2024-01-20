import 'package:core/core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/models/models.dart';
import 'package:melodify/theme/palette.dart';

@LazySingleton()
class LocalNotification {
  static const channelId = 'high_importance_channel';
  static const channelName = 'Notifications';

  late final FlutterLocalNotificationsPlugin _notificationsPlugin;

  LocalNotification()
      : _notificationsPlugin = FlutterLocalNotificationsPlugin();

  //  Instantiate Notifications Plugin
  // final BehaviorSubject<bool?> hasNotificationSubject =
  //     BehaviorSubject<bool?>();

  final channel = const AndroidNotificationChannel(
    channelId,
    channelName,
    importance: Importance.high,
  );

  Future<void> initialize() async {
    try {
      // Android Initialization Settings
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      // IOS Initialization Settings
      final iOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          log.logMapAsTable({
            'id': id,
            'title': title,
            'body': body,
            'payload': payload,
          }, header: 'iOS notification');
        },
      );
      // Initialization Settings
      final settings = InitializationSettings(android: android, iOS: iOS);

      // Create notification channel
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Terminated App
      final notificationAppLaunchDetails =
          await _notificationsPlugin.getNotificationAppLaunchDetails();
      final NotificationAppLaunchDetails(
        :didNotificationLaunchApp,
        :notificationResponse
      ) = notificationAppLaunchDetails!;

      if (didNotificationLaunchApp) {
        log.trace('Notification Launch App');
        onMessageOpenedApp(notificationResponse?.payload);
      } else {
        // Initialize Notifications Plugin
        await _notificationsPlugin.initialize(
          settings,
          onDidReceiveNotificationResponse: (response) async {
            log.trace(response);
            onMessageOpenedApp(response.payload);
          },
        );
      }
      log.trace('Initialize successfully');
    } catch (e) {
      log.error(e);
    }
  }

  void onMessageOpenedApp(String? path) {
    if (path.isNullOrEmpty) return;
    Routing().pushNamed(path!);
  }

  Future<void> showNotification(NotificationData notification) async {
    try {
      final NotificationData(:id, :title, :body, :payload) = notification;
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Palette.primary500,
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: const DarwinNotificationDetails(
          sound: 'default',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      // hasNotificationSubject.sink.add(true);
      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      log.error(e);
    }
  }

  // show notification
  void showNotificationDownload({
    required int count,
    required int i,
    required int id,
  }) {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        color: Palette.primary500,
        importance: Importance.max,
        priority: Priority.max,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: count,
        progress: i,
      ),
      iOS: const DarwinNotificationDetails(
        sound: 'default',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    _notificationsPlugin.show(
      id,
      'Download',
      'Download file $i/$count',
      notificationDetails,
    );
  }

  // Get pending notifications
  Future<int> getPendingNotificationCount() async {
    final total = await _notificationsPlugin.pendingNotificationRequests();
    log.trace('Pending Notification Count --> ${total.length}');
    return total.length;
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

// Download image from url
// Future<String> downloadAndSaveFile(String url, String fileName) async {
//   try {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final Response response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//         followRedirects: false,
//         validateStatus: (status) {
//           return status! < 500;
//         },
//       ),
//     );
//     final File file = File(filePath);
//     await file.writeAsBytes(response.data);
//     return filePath;
//   } catch (e) {
//     log('[dioError]: $e');
//     throw Exception('Failed to download file');
//   }
// }
}
