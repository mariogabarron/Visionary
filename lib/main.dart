import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visionary/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visionary/views/tutorial_inicio/tutorial_inicio.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:visionary/services/notifications/notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await MobileAds.instance.initialize();

  await NotificationHandler.initializaNotificationPlugin();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Visionary',
    theme: ThemeData(
      colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 48, 48, 48)),
      useMaterial3: true,
    ),
    home: const TutorialInicio(),
    onGenerateRoute: generateRoute,
  ));
}
