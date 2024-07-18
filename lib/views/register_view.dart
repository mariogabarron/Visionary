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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Text(
                  "Crea tu cuenta.",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 23,
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(
                  label: "¿Cómo te llamas?",
                  hintText: "Escribe tu nombre",
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Correo electrónico",
                  hintText: "Escribe tu correo",
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Contraseña",
                  hintText: "Escribe tu contraseña",
                  obscureText: false,
                ),
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
                      'Crea tu cuenta',
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
                const SizedBox(height: 20),
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
                ),
                const SizedBox(height: 20),
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
    );
  }

  Widget _buildInputField(
      {required String label, String? hintText, bool obscureText = false}) {
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
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(89, 218, 185, 159),
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors
                    .transparent, // Make the background transparent so that the container's color is visible
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 122, 121, 115),
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
}
