import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlertPorque(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Obtenemos el tamaño del teclado y la altura de la pantalla disponible
      var mediaQuery = MediaQuery.of(context);
      var screenHeight = mediaQuery.size.height;
      var keyboardHeight = mediaQuery.viewInsets.bottom;

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFEFCEE),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenHeight -
                keyboardHeight -
                100, // Ajustamos la altura del AlertDialog
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  '¿Por qué lo hago?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: const Color(0xFF26272C),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '“Quien sabe a dónde va y por qué, es quien consigue llegar”',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  autofocus: false,
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
        ),
      );
    },
  );
}
