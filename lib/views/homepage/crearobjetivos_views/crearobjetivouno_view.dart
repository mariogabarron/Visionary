import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';
import 'package:visionary/utilities/buildinputfield.dart';
import 'package:visionary/utilities/showdialogs/objetivovacio_showdialog.dart';
import 'package:visionary/utilities/showdialogs/repetido_showdialog.dart';
import 'package:visionary/views/homepage/crearobjetivos_views/crearobjetivodos_view.dart';

class CrearObjetivoUnoView extends StatefulWidget {
  const CrearObjetivoUnoView({super.key});

  @override
  State<CrearObjetivoUnoView> createState() => _CrearObjetivoUnoViewState();
}

class _CrearObjetivoUnoViewState extends State<CrearObjetivoUnoView> {
  late TextEditingController _nombreObjetivoEditingController;
  @override
  void initState() {
    _nombreObjetivoEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nombreObjetivoEditingController.dispose();
    super.dispose();
  }

  Future<bool> _isNombreObjetivoDuplicado(String nombre) async {
    VisionaryUser user = await VisionaryUser.fromLogin();
    List<String> nombresObjetivos =
        user.objectives.map((objetivo) => objetivo.$1).toList();
    return nombresObjetivos.any((nombreExistente) =>
        nombreExistente.toLowerCase() == nombre.toLowerCase());
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
            colors: [Color(0xFF6D97AC), Color.fromARGB(255, 207, 175, 148)],
            transform: GradientRotation(88 * pi / 180),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text('¿Cúal es el objetivo que te gustaría cumplir?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              buildInputField(
                  label: "",
                  inputType: TextInputType.name,
                  hintText: "Escríbelo en una palabra",
                  controller: _nombreObjetivoEditingController,
                  maxWords: 16),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text('Podrás modificarlo más tarde',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 233, 232, 220),
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Color(0xFFFEFCEE),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(homepageView);
                      },
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      null,
                      color: Color(0xFFFEFCEE),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Color(0xFFFEFCEE),
                      ),
                      onPressed: () async {
                        String nuevoNombre =
                            _nombreObjetivoEditingController.text.trim();
                        nuevoNombre = nuevoNombre.replaceAll(RegExp(r'\s+'),
                            ' '); // Reemplazar múltiples espacios por uno solo

                        if (nuevoNombre.isNotEmpty) {
                          bool isDuplicado =
                              await _isNombreObjetivoDuplicado(nuevoNombre);
                          if (isDuplicado) {
                            if (context.mounted) showAlertRepetido(context, 1);
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                                buildFadeRoute(CrearObjetivoDosView(
                                    nombreTarea: nuevoNombre)));
                          }
                        } else {
                          showAlertObjetivoVacio(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
