import 'package:flutter/material.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/homepage_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
