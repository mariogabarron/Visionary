import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareatres_view.dart';

class CreaTareaDosView extends StatefulWidget {
  final String objectiveRef;
  final String nombreTarea;

  const CreaTareaDosView(
      {super.key, required this.nombreTarea, required this.objectiveRef});

  @override
  State<CreaTareaDosView> createState() => _CreaTareaDosViewState();
}

class _CreaTareaDosViewState extends State<CreaTareaDosView>
    with SingleTickerProviderStateMixin {
  int _selectedPriority = 1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFFFEFCEE),
        ),
        title: Text(
          'Visionary.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontSize: 30,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D97AC), Color.fromARGB(255, 207, 175, 148)],
            transform: GradientRotation(88 * pi / 180),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  '¿Qué prioridad tiene esta tarea?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontSize: 23,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int priority = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPriority = priority;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _selectedPriority == priority
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _animation.value * 2 * pi,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6D97AC),
                                              Color.fromARGB(255, 207, 175, 148)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  '$priority',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Text(
                                  '$priority',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'Priorizar te ayudará a cumplir mejor tus tareas',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 233, 232, 220),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(buildFadeRoute(
                      CreaTareaTresView(
                          nombreTarea: widget.nombreTarea,
                          prioridad: _selectedPriority,
                          objectiveRef: widget.objectiveRef)));
                },
                icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                color: const Color(0xFFFEFCEE),
              )
            ],
          ),
        ),
      ),
    );
  }
}
