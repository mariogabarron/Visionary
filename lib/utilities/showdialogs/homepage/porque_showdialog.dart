import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

void showAlertPorque(
    BuildContext context, String objetivo, VoidCallback onUpdated) async {
  TextEditingController textController = TextEditingController();
  bool isEditing = false;
  DatabaseReference objetivoRef = FirebaseDatabase.instance.ref(objetivo);

  // Carga el valor inicial del propósito
  DataSnapshot snapshot = await objetivoRef.child('motive').get();
  if (snapshot.exists) {
    textController.text = snapshot.value.toString();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      var mediaQuery = MediaQuery.of(context);
      var screenHeight = mediaQuery.size.height;
      var keyboardHeight = mediaQuery.viewInsets.bottom;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color(0xFFFEFCEE),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenHeight - keyboardHeight - 100,
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
                      "Escribe aquí el por qué quieres lograrlo",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: const Color.fromARGB(183, 40, 40, 40),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      child: isEditing
                          ? TextFormField(
                              controller: textController,
                              autofocus: true,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF26272C),
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: "Escribe por qué quieres lograrlo...",
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color.fromARGB(183, 40, 40, 40),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(66, 254, 252, 238),
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(66, 254, 252, 238),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                textController.text.isEmpty
                                    ? "Escribe aquí..."
                                    : textController.text,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF26272C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
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
                        objetivoRef.update({
                          'motive': textController.text,
                        }).then((_) {
                          if (context.mounted) {
                            onUpdated(); // Llama al callback después de guardar
                            Navigator.of(context).pop();
                          }
                        }).catchError((error) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error al guardar el propósito: $error',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 54, 54, 54),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        'Guardar',
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
    },
  );
}
