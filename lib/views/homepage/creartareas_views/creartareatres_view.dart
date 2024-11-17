import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareascuatro_view.dart';

class CreaTareaTresView extends StatefulWidget {
  final String nombreTarea;
  final int prioridad;
  final String objectiveRef;

  const CreaTareaTresView(
      {super.key,
      required this.nombreTarea,
      required this.prioridad,
      required this.objectiveRef});

  @override
  State<CreaTareaTresView> createState() => _CreaTareaTresViewState();
}

class _CreaTareaTresViewState extends State<CreaTareaTresView> {
  int _selectedFrequency = 1;
  int _selectedRepeticiones = 1;

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
                  '¿Quieres que tu tarea se repita?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontSize: 23,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  String label;
                  switch (index) {
                    case 0:
                      label = 'Se repite';
                      break;
                    case 1:
                      label = 'No se repite';
                      break;
                    default:
                      label = '';
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFrequency = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: _selectedFrequency == index
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF6D97AC),
                                  Color.fromARGB(255, 207, 175, 148)
                                ],
                              )
                            : LinearGradient(
                                colors: [Colors.grey[300]!, Colors.grey[400]!],
                              ),
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          color: _selectedFrequency == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              _selectedFrequency == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_selectedRepeticiones > 1) {
                                      _selectedRepeticiones--;
                                    }
                                  });
                                },
                                icon: const Icon(
                                    CupertinoIcons.minus_circle_fill),
                                color: Colors.white,
                                iconSize: 25,
                              ),
                              Text(
                                '$_selectedRepeticiones',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedRepeticiones++;
                                  });
                                },
                                icon: const Icon(
                                    CupertinoIcons.add_circled_solid),
                                color: Colors.white,
                                iconSize: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  _selectedFrequency == 0
                      ? "Selecciona el total de veces que debes de cumplir esta tarea para darla por finalizada."
                      : _selectedFrequency == 1
                          ? "Tu tarea sólo se debe cumplir una vez para finalizarse."
                          : "Selecciona \"Se repite\" si tu tarea se debe cumplir más de una vez para darse por finalizada.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(buildFadeRoute(CreaTareaCuatroView(
                    nombre: widget.nombreTarea,
                    prioridad: widget.prioridad,
                    vecesQueSeDebeDeHacer: _selectedRepeticiones,
                    objectiveRef: widget.objectiveRef,
                  )));
                },
                icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                color: const Color(0xFFFEFCEE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
