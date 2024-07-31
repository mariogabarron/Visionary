import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlertBottomEditarObjetivo(BuildContext context, String objetivo) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: const Color(0xFFFEFCEE),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Editar objetivo "$objetivo"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: const Color(0xFF26272C),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Cambiar nombre al objetivo $objetivo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                    label: "",
                    inputType: TextInputType.name,
                    hintText: "Escribe el nuevo nombre",
                    maxWords: 20),
                const SizedBox(height: 30),
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
                    'Guardar',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: Divider(color: Colors.black38),
                ),
                const SizedBox(height: 25),
                Text(
                  'Eliminar objetivo $objetivo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D97AC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Acción de borrar cuenta
                      },
                      child: Text(
                        'Borrar',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
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
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
              fontWeight: FontWeight.bold,
            ),
            maxLength: maxWords,
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
