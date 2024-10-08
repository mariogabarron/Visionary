import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:visionary/routes/routes.dart';

class TareaCreadaView extends StatefulWidget {
  const TareaCreadaView({super.key});

  @override
  State<TareaCreadaView> createState() => _TareaCreadaViewState();
}

class _TareaCreadaViewState extends State<TareaCreadaView> {
  @override
  void initState() {
    super.initState();
    _navigateToTutorialUno();
  }

  void _navigateToTutorialUno() async {
    await Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {});
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(homepageView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Color(0xFFFEFCEE),
            ),
            title: Text('Visionary.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFEFCEE),
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF6D97AC), Color.fromARGB(255, 207, 175, 148)],
                transform: GradientRotation(88 * pi / 180)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Tarea creada correctamente',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  fontStyle: FontStyle.normal,
                  color: const Color(0xFFFEFCEE),
                ),
              ),
            ),
          ),
        ));
  }
}
