import 'package:flutter/material.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/splash_screen.dart';
import 'package:visionary/views/tutorial/tutorial_cuatro.dart';
import 'package:visionary/views/tutorial/tutorial_dos.dart';
import 'package:visionary/views/tutorial/tutorial_tres.dart';
import 'package:visionary/views/tutorial/tutorial_uno.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Visionary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        splashScreen: (context) => const SplashScreen(),
        tutorialUno: (context) => const TutorialUno(),
        tutorialDos: (context) => const TutorialDos(),
        tutorialTres: (context) => const TutorialTres(),
        tutorialCuatro: (context) => const TutorialCuatro(),
      },
    )
  );
}
