import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';

class TutorialCuatro extends StatefulWidget {
  const TutorialCuatro({super.key});

  @override
  State<TutorialCuatro> createState() => _TutorialCuatroState();
}

class _TutorialCuatroState extends State<TutorialCuatro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text('Visionary.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontStyle: FontStyle.normal,
              )),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6D97AC), Color(0xFFF6D0B1)],
                transform: GradientRotation(88 * pi / 180),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/tutorialcuatro.png'),
                Padding(
                  padding: const EdgeInsets.all(30.0),
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
                              text: "Lleva el control",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " de tus\nobjetivos.",
                            ),
                          ])),
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
                              tutorialTres, (route) => true);
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
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_downward_sharp,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              registerView, (route) => true);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
