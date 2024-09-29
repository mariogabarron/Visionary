import 'package:flutter/material.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/homepage_view.dart';
import 'package:visionary/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'Visionary',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomepageView(),
    onGenerateRoute: generateRoute,
  ));
}
