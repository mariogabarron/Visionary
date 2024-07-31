import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/utilities/buildinputfield.dart';

class CreaTareaUnoView extends StatefulWidget {
  const CreaTareaUnoView({super.key});

  @override
  State<CreaTareaUnoView> createState() => _CreaTareaUnoViewState();
}

class _CreaTareaUnoViewState extends State<CreaTareaUnoView> {
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
                    '¿Cómo se llama la tarea que quieres cumplir para tu objetivo?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              buildInputField(
                  label: "",
                  inputType: TextInputType.name,
                  hintText: "Escribe el título de tu tarea",
                  maxWords: null),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text('Podrás modificarlo más tarde',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 233, 232, 220),
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ))),
              const SizedBox(height: 20),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(crearTareaDos);
                  },
                  icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                  color: const Color(0xFFFEFCEE))
            ],
          ),
        ),
      ),
    );
  }
}
