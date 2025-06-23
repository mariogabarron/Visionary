import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visionary/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visionary/views/homepage/homepage_view.dart';
import 'package:visionary/views/tutorial_inicio/tutorial_inicio.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:visionary/services/notifications/notification_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  // TODO: (solo para pruebas)
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['bfea609d000cd46dc379f55c65a11c3d'],
    ),
  );

  await MobileAds.instance.initialize();
  await NotificationHandler.initializaNotificationPlugin();

  // Inicializa el plugin de notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Configura la zona horaria para notificaciones programadas
  tz.initializeTimeZones();

  await _scheduleDailyNotification();

  // Espera un poco para asegurar que el splash se muestre (opcional, pero ayuda en dispositivos rápidos)
  await Future.delayed(const Duration(milliseconds: 600));

  FlutterNativeSplash.remove();

  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(isLoggedIn: user != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visionary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 70, 70, 70)),
        useMaterial3: true,
      ),
      home: isLoggedIn
          ? HomepageView()
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return HomepageView();
                }
                return TutorialInicio();
              },
            ),
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> _scheduleDailyNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'daily_channel_id',
    'Recordatorio diario',
    channelDescription: 'Notificación diaria a las 12:00',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  final now = DateTime.now();
  final nextNoon = DateTime(now.year, now.month, now.day, 12, 0, 0);
  final firstNotification =
      now.isAfter(nextNoon) ? nextNoon.add(const Duration(days: 1)) : nextNoon;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Visionary hour! :)',
    'No olvides revisar tus tareas de hoy en Visionary.',
    tz.TZDateTime.from(firstNotification, tz.local),
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
}
