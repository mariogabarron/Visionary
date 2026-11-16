import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Stack showAlertConnectionLost(BuildContext context) {
  return Stack(
    children: [
      // Fondo que ocupa toda la pantalla
      Container(
        color: Colors.black.withOpacity(0.5), // Fondo semitransparente
      ),
      // Diálogo centrado
      Center(
        child: Dialog(
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
                  'Se ha perdido la conexión',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: const Color(0xFF26272C),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Para usar Visionary necesitas estar conectado a Internet. Comprueba tu conexión.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: const Color.fromARGB(255, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
