import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';

class TutorialDos extends StatefulWidget {
  const TutorialDos({super.key});

  @override
  State<TutorialDos> createState() => _TutorialDosState();
}

class _TutorialDosState extends State<TutorialDos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Visionary.',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.normal,
            color: const Color(0xFFFEFCEE),
          ),
        ),
      ),
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/tutorialdos.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontStyle: FontStyle.normal,
                          color: const Color(0xFFFEFCEE),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Organizar por objetivos\n",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: " te ayudará a mejorar cada día",
                          ),
                        ]
                      )
                    ),  
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_upward_sharp,
                        color: Color(0xFFFEFCEE),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          tutorialUno, (route) => true
                        );
                      },
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      null,
                      color: Color(0xFFFEFCEE),
                    ),
                  ),  
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_downward_sharp,
                      color: Color(0xFFFEFCEE),
                    ),
                  ),                   
                ],        
              )
            ],
        ),
      ),
    );
  }
}
