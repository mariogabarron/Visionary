import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// ignore: constant_identifier_names
const ANDROID_NOTIFICATION_ICON = 'background';

class NotificationHandler {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings androidConfig =
      AndroidInitializationSettings(ANDROID_NOTIFICATION_ICON);

  static final DarwinInitializationSettings iOSConfig =
      DarwinInitializationSettings();

  // Cambia el nombre para mantener compatibilidad con tu main.dart
  static Future<void> initializaNotificationPlugin() async {
    await initializeNotificationPlugin();
  }

  static Future<void> initializeNotificationPlugin() async {
    tz.initializeTimeZones();
    var finalSettings =
        InitializationSettings(android: androidConfig, iOS: iOSConfig);
    await flutterLocalNotificationsPlugin.initialize(finalSettings);
  }

  static Future<bool?> requestPermissions() async {
    // iOS permissions
    final ios =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    // Android 13+ permissions
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    required DateTime scheduledDate,
    String? payload,
    String timeZone = "Europe/Madrid",
  }) async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    // Asegura que las zonas horarias estén inicializadas
    tz.initializeTimeZones();
    final location = tz.getLocation(timeZone);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title ?? 'Scheduled Notification',
      body ?? 'This is a test notification',
      tz.TZDateTime.from(scheduledDate, location),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents
          .time, // Para notificaciones recurrentes, si lo necesitas
    );
  }
}

// Ejemplo de cómo programar una notificación desde cualquier parte de tu app:
// Importa NotificationHandler y llama a este método:

/*
await NotificationHandler().scheduleNotification(
  id: 1,
  title: '¡Hola!',
  body: 'Esta es una notificación de prueba',
  scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
);
*/

// Esto enviará una notificación local en 10 segundos.
// Asegúrate de haber llamado antes a:
// await NotificationHandler.initializaNotificationPlugin();
// y de haber pedido permisos con:å
// await NotificationHandler.requestPermissions();
