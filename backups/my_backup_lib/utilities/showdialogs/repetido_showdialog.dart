import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Si tipo = 1, entonces es un objetivo repetido
// Si tipo = 2, entonces es una tarea repetida
void showAlertRepetido(BuildContext context, int tipo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFEFCEE),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                tipo == 1
                    ? 'Ya existe un objetivo con ese nombre.'
                    : 'Ya existe una tarea con ese nombre.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFF26272C),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                tipo == 1
                    ? 'Si quieres crear un nuevo objetivo, debes de escribir otro nombre.'
                    : 'Si quieres crear una nueva tarea, debes de escribir otro nombre.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: const Color.fromARGB(255, 40, 40, 40),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}
