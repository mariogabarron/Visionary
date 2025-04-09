import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class TutorialInicio extends StatefulWidget {
  const TutorialInicio({super.key});

  @override
  State<TutorialInicio> createState() => _TutorialInicioState();
}

class _TutorialInicioState extends State<TutorialInicio> {
  final List<Map<String, String>> tutorials = [
    {
      'image': 'assets/images/tutorialuno.png',
      'title': 'Visionary',
      'text': 'es la herramienta que te ayuda a entender tu vida',
    },
    {
      'image': 'assets/images/tutorialdos.png',
      'title': 'Organizar por objetivos',
      'text': 'te ayudará a mejorar cada día',
    },
    {
      'image': 'assets/images/tutorialtres.png',
      'title': 'Crea tareas',
      'text': 'que te ayuden a cumplir tus objetivos',
    },
    {
      'image': 'assets/images/tutorialcuatro.png',
      'title': 'Lleva el control',
      'text': 'de tus objetivos.',
    },
  ];

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    inicialization();
  }

  void inicialization() async {
    await Future.delayed(const Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  void nextPage() {
    if (currentPage < tutorials.length - 1) {
      setState(() {
        currentPage++;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(registerView, (route) => false);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Visionary.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: const Color(0xFFFEFCEE),
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento táctil
        itemCount: tutorials.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
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
                Image.asset(tutorials[index]['image']!),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: const Color(0xFFFEFCEE),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: tutorials[index]['title']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "\n${tutorials[index]['text']!}",
                        ),
                      ],
                    ),
                  ),
                ),
                // ...existing code...
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: currentPage == 0
                      ? [
                          RotatedBox(
                            quarterTurns: 3,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_downward_sharp,
                                color: Color(0xFFFEFCEE),
                              ),
                              onPressed: nextPage,
                            ),
                          ),
                        ]
                      : [
                          RotatedBox(
                            quarterTurns: 3,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_upward_sharp,
                                color: Color(0xFFFEFCEE),
                              ),
                              onPressed: previousPage,
                            ),
                          ),
                          const SizedBox(width: 20), // Espaciado entre botones
                          RotatedBox(
                            quarterTurns: 3,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_downward_sharp,
                                color: Color(0xFFFEFCEE),
                              ),
                              onPressed: nextPage,
                            ),
                          ),
                        ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
