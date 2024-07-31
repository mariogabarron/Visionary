import 'package:flutter/material.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/homepagevacio_view.dart';
import 'package:visionary/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Visionary',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomepageVacioView(),
    onGenerateRoute: generateRoute,
  ));
}
