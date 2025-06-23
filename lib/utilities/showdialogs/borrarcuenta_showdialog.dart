import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';

import '../../services/auth/auth_user.dart';

void showAlertBorrarCuenta(BuildContext context) {
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
              const SizedBox(height: 20),
              Text(
                '¿Seguro que quieres borrar tu cuenta?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: const Color(0xFF26272C),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Si borras tu cuenta, todos tus datos se borrarán permanentemente',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: const Color.fromARGB(255, 40, 40, 40),
                ),
              ),
              const SizedBox(height: 40),
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
                      deleteAccount();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerView, (route) => false);
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
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}
