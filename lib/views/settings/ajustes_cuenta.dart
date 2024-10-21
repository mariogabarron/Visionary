import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/auth/auth_user.dart';
import 'package:visionary/utilities/showdialogs/borrarcuenta_showdialog.dart';

class AjustesCuenta extends StatefulWidget {
  const AjustesCuenta({super.key});

  @override
  State<AjustesCuenta> createState() => _AjustesCuentaState();
}

class _AjustesCuentaState extends State<AjustesCuenta> {
  void _cerrarSesion() {
    logOut();
    Navigator.of(context).pushReplacementNamed(loginView);
  }

  void _politicaPrivacidad() {}
  void _terminosYCondiciones() {}
  void _valorarApp() {}
  void _borrarCuenta() {
    showAlertBorrarCuenta(context);
  }

  void ayudaConfiguracion() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Stack(
          children: [
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(CupertinoIcons.arrow_left_circle_fill),
                color: const Color(0xFFFEFCEE),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(homepageView);
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Visionary.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFEFCEE),
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF6D97AC), Color.fromARGB(255, 207, 175, 148)],
              transform: GradientRotation(88 * pi / 180)),
        ),
        child: SizedBox.expand(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Text(
                  "Configuración",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 40),*/
                GestureDetector(
                  onTap: ayudaConfiguracion,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Ayuda',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _politicaPrivacidad,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Política de privacidad',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _valorarApp,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Valorar aplicación',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _terminosYCondiciones,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                      /*boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 218, 185, 159),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],*/
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Términos y condiciones',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _cerrarSesion,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                      /*boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 218, 185, 159),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],*/
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Cerrar sesión',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _borrarCuenta,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 254, 252, 238),
                      borderRadius: BorderRadius.circular(30.0),
                      /*boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 218, 185, 159),
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],*/
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Borrar cuenta',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
