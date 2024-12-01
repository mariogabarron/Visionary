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
                const SizedBox(height: 16),
                Text(
                  'Propósito',
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
                _buildInputField(
                  hintText: "Tu propósito con esta meta...",
                  label: "",
                  inputType: TextInputType.name,
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

Widget _buildInputField(
    {required String label,
    String? hintText,
    bool obscureText = false,
    required TextInputType inputType,
    int? maxWords}) {
  TextInputType keyboardType = TextInputType.text;

  if (inputType == TextInputType.emailAddress) {
    keyboardType = TextInputType.emailAddress;
  } else if (inputType == TextInputType.visiblePassword) {
    keyboardType = TextInputType.visiblePassword;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(66, 254, 252, 238),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            keyboardType: keyboardType,
            maxLength: maxWords,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
              fontWeight: FontWeight.bold,
            ),
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(66, 76, 76, 76),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
