import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/progressbar.dart';

void showAlertProgreso(BuildContext context, double porcentaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFEFCEE),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                'Progreso',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: const Color(0xFF26272C),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Cada 1% te acerca un poco más al resultado',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: const Color.fromARGB(183, 40, 40, 40),
                ),
              ),
              const SizedBox(height: 30),
              ProgressBar(porcentaje: porcentaje),
              const SizedBox(height: 30),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: const Color.fromARGB(183, 40, 40, 40),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Actualmente, llevas cumplido un \n",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: "${(porcentaje * 100).toStringAsFixed(1)}%",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " de tu objetivo.",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ])),
              const SizedBox(height: 20),
              Text(
                'Sigue cumpliendo el resto de tus tareas para cumplir tu objetivo.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: const Color.fromARGB(183, 40, 40, 40),
                ),
              ),
              const SizedBox(height: 50),
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
                  'Continuar',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
