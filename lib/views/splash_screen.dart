import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Visionary.",
          style:  GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        )
      ],
    );
  }
}