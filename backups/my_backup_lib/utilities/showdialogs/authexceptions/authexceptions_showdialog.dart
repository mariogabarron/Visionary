import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlertAuthException(BuildContext context, String exception) {
  String title;
  String message;

  switch (exception) {
    case 'invalid-credential':
      title = 'Credenciales inválidas';
      message =
          'Las credenciales proporcionadas son incorrectas. Intenta de nuevo.';
      break;
    case 'email-already-in-use':
      title = 'Email ya en uso';
      message =
          'Este correo electrónico ya está registrado. Usa otro correo o inicia sesión.';
      break;
    case 'invalid-email':
      title = 'Email no válido';
      message =
          'Este correo electrónico no es válido. Asegúrate que tiene el formato de email.';
      break;
    case 'user-not-found':
      title = 'Usuario no encontrado';
      message = 'No hay ningún usuario registrado con este correo electrónico.';
      break;
    case 'too-many-requests':
      title = 'Muchas solicitudes';
      message =
          'Estamos recibiendo muchas solicitudes. Inténtalo de nuevo más tarde.';
      break;
    case 'invalid-password':
    case 'weak-password':
      title = 'Contraseña no válida';
      message = 'La contraseña debe contener al menos 6 caracteres';
      break;
    default:
      title = 'Error';
      message = 'Ocurrió un error. Por favor, intenta de nuevo.';
      break;
  }

  // Mostrar el diálogo
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
                title, // Título dinámico
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFF26272C),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                message, // Mensaje dinámico
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
