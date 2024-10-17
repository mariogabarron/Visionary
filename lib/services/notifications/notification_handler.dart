import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const ANDROID_NOTIFICATION_ICON = 'background';

class NotificationHandler {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings androidConfig = AndroidInitializationSettings(ANDROID_NOTIFICATION_ICON);
  static final DarwinInitializationSettings iOSConfig = DarwinInitializationSettings();

  static Future<void> initializaNotificationPlugin() async {
    var finalSettings = InitializationSettings(android: androidConfig, iOS: iOSConfig);
    await flutterLocalNotificationsPlugin.initialize(finalSettings);
  }

  static Future<bool?> requestPermissions() async {
    return flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  /// ESTO ES UN COPIA Y PEGA TODO: REVISAR ESTA FUNCION
  Future<void> scheduleNotification() async {
    var androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max, priority: Priority.high);

    var iOSDetails = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iOSDetails);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Scheduled Notification',
        'This is a test notification',
        tz.TZDateTime.now(tz.getLocation("Europe/Madrid")).add(Duration(seconds: 10)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

}