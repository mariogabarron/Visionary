import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTres extends StatefulWidget {
  const TutorialTres({super.key});

  @override
  State<TutorialTres> createState() => _TutorialTresState();
}

class _TutorialTresState extends State<TutorialTres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Visionary.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.normal,
          )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/tutorialtres.png'),
        ],
      )
    );
  }
}