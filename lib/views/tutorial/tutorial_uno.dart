import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialUno extends StatefulWidget {
  const TutorialUno({super.key});

  @override
  State<TutorialUno> createState() => _TutorialUnoState();
}

class _TutorialUnoState extends State<TutorialUno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6D97AC),
              Color(0xFFF6D0B1)
            ],
            transform: GradientRotation(88 * pi / 180)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.00, vertical: 80.00),
          child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 0.00, vertical: 10.00),
                  child: Text(
                    'Visionary.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      color: const Color(0xFFFEFCEE),
                    ),
                  ),
                ),
                const Placeholder(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Text(
                      "Visionary es la herramienta que te ayuda a entender tu vida.",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFFFEFCEE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_upward_sharp,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: null,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_downward_sharp,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                )
          
              ],
            ),
        ),
        ),
      
    );
  }
}