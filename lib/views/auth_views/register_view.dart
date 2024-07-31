import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/utilities/buildinputfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  void _register() {
    Navigator.of(context).pushReplacementNamed(homepageVacioView);
  }

  void _googleLogin() {
    Navigator.of(context).pushReplacementNamed(homepageVacioView);
  }

  void _alreadyGotAccount() {
    Navigator.of(context).pushReplacementNamed(loginView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox.expand(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Crea tu cuenta",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 40),
                  buildInputField(
                      label: "¿Cómo te llamas?",
                      hintText: null, //"Escribe tu nombre",
                      obscureText: false,
                      inputType: TextInputType.text),
                  const SizedBox(height: 20),
                  buildInputField(
                      label: "Correo electrónico",
                      hintText: null, //"Escribe tu correo",
                      obscureText: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  buildInputField(
                      label: "Contraseña",
                      hintText: null, //"Escribe tu contraseña",
                      obscureText: true,
                      inputType: TextInputType.visiblePassword),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _register,
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
                        'Registrarse',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFEFCEE),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                    child: Divider(color: Color(0xFFFEFCEE)),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _googleLogin,
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
                          SvgPicture.network(
                            'https://fonts.gstatic.com/s/i/productlogos/googleg/v6/24px.svg',
                            height: 24.0,
                            width: 24.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            'Registrarse con Google',
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
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _alreadyGotAccount,
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
                        '¿Ya tienes una cuenta?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFEFCEE),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
