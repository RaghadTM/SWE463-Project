import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  // initialize notifications settings
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(settings);

    // ask for notification permission
    final androidPlugin =
    _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
  }

  // simple helper to show an instant notification
  static Future<void> showInstantNotification(
      String title,
      String body, {
        int id = 0,
      }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _notifications.show(id, title, body, details);
  }

  // enable prayer time notification with id 1
  static Future<void> schedulePrayerNotification() async {
    await showInstantNotification(
      'Prayer Time Alerts',
      'Prayer time alerts have been enabled.',
      id: 1,
    );
  }


  static Future<void> cancelPrayerNotification() async {
    await _notifications.cancel(1);
  }

  // enable daily hadith notification
  static Future<void> scheduleDailyHadithNotification() async {
    await showInstantNotification(
      'Daily Hadith',
      'Daily hadith notifications have been enabled.',
      id: 2,
    );
  }

  // stop daily hadith notification with id 2
  static Future<void> cancelDailyHadithNotification() async {
    await _notifications.cancel(2);
  }
}
