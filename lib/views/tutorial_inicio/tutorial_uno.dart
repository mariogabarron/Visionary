import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';

class TutorialUno extends StatefulWidget {
  const TutorialUno({super.key});

  @override
  State<TutorialUno> createState() => _TutorialUnoState();
}

class _TutorialUnoState extends State<TutorialUno> {
  @override
  void initState() {
    super.initState();
    inicialization();
  }

  void inicialization() async {
    print("pausing...");
    await Future.delayed(const Duration(seconds: 4));
    print("unpausing");
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              colors: [Color(0xFF6D97AC), Color(0xFFF6D0B1)],
              transform: GradientRotation(88 * pi / 180)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/tutorialuno.png'),
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
                          text: "Visionary",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: " es la herramienta que te ayuda a",
                        ),
                        TextSpan(
                          text: " entender tu vida",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
                          tutorialDos, (route) => false);
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
                          tutorialDos, (route) => false);
                    },
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
