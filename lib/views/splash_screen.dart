import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:visionary/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _navigateToTutorialUno();
    });
  }

  void _navigateToTutorialUno() {
    Navigator.of(context).pushReplacementNamed(tutorialUno);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF6D97AC), Color(0xFFF6D0B1)],
            transform: GradientRotation(88 * pi / 180)),
      ),
      child: Align(
        alignment: const Alignment(0, -0.05),
        child: Text(
          'Visionary.',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            fontStyle: FontStyle.normal,
            color: const Color(0xFFFEFCEE),
          ),
        ),
      ),
    ));
  }
}
