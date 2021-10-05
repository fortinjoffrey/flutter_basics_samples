import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class LocalNotificationSource {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static void init() {
    final androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    _notifications.initialize(
      InitializationSettings(android: androidSettings),
      onSelectNotification: (payload) async {
        OpenFile.open(payload);
      },
    );
  }

  static Future<NotificationDetails> _notificationDetails(String? filepath) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
        largeIcon: filepath != null ? FilePathAndroidBitmap(filepath) : null,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future<void> show({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? filepath,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(filepath), payload: payload);
}
