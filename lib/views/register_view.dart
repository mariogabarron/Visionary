import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  void _register() {}
  void _googleLogin() {}
  void _alreadyGotAccount() {}

  /*var _textEditingControllerName;
  var _textEditingControllerEmail;
  var _textEditingControllerPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingControllerName.dispose();
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: true,
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
            colors: [Color(0xFF6D97AC), Color(0xFFF6D0B1)],
            transform: GradientRotation(88 * pi / 180),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Crea tu cuenta",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 23,
              ),
            ),
            Text(
              "¿Cómo te llamas?",
              style: GoogleFonts.poppins(
                  color: const Color(0xFFFEFCEE),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 15),
            ),
            const TextField(),
            Text(
              "Correo electrónico",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 15,
              ),
            ),
            const TextField(),
            Text(
              "Contraseña",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 15,
              ),
            ),
            const TextField(),
            TextButton(
              onPressed: null,
              child: Text("Crea tu cuenta",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                  )),
            ),
            // linea divisoria
            TextButton(
                onPressed: null,
                child: GestureDetector(
                  onTap: () {
                    //print("Iniciar sesión con Google");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 218, 185, 159),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /*Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                          height: 24.0,
                          width: 24.0,
                        ),*/
                        const SizedBox(width: 10.0),
                        Text(
                          'Inicia sesión con Google',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFEFCEE),
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            TextButton(
                onPressed: null,
                child: GestureDetector(
                  onTap: () {
                    //print("Iniciar sesión con Google");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 218, 185, 159),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      '¿Ya tienes cuenta?',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFFEFCEE),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 16),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
