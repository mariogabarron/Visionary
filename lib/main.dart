import 'package:flutter/material.dart';
import 'package:visionary/views/splash_screen.dart';
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
      home: const TutorialUno(),
      routes: {
        "/splash-screen/": (context) => const SplashScreen(),
        "/tutorial-uno/": (context) => const TutorialUno(),
      },
    )
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {  
    return const Placeholder();
  }
}
