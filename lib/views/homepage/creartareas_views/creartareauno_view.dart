import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/utilities/buildinputfield.dart';
import 'package:visionary/utilities/showdialogs/objetivovacio_showdialog.dart';
import 'package:visionary/utilities/showdialogs/repetido_showdialog.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareados_view.dart';

class CreaTareaUnoView extends StatefulWidget {
  final String objectiveRef;

  const CreaTareaUnoView({super.key, required this.objectiveRef});

  @override
  State<CreaTareaUnoView> createState() => _CreaTareaUnoViewState();
}

class _CreaTareaUnoViewState extends State<CreaTareaUnoView> {
  late TextEditingController _nombreTareaEditingController;
  @override
  void initState() {
    _nombreTareaEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nombreTareaEditingController.dispose();
    super.dispose();
  }

  Future<bool> _isNombreTareaDuplicado(String nombre) async {
    // Obtiene el objetivo desde la referencia
    Objetivo objetivo = await Objetivo.fromRef(
        FirebaseDatabase.instance.ref(widget.objectiveRef));

    // Obtiene la lista de nombres de las tareas
    List<String> nombresTareas =
        objetivo.listaTareas.map((tarea) => tarea.name.toLowerCase()).toList();

    // Verifica si el nombre ya existe
    return nombresTareas.contains(nombre.toLowerCase());
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
                child: Text('¿Cómo se llama la tarea que quieres cumplir?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              buildInputField(
                  label: "",
                  inputType: TextInputType.name,
                  hintText: "Escribe el título de tu tarea",
                  maxWords: null,
                  controller: _nombreTareaEditingController),
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
                        String nombreTarea =
                            _nombreTareaEditingController.text.trim();
                        nombreTarea = nombreTarea.replaceAll(RegExp(r'\s+'),
                            ' '); // Reemplazar múltiples espacios por uno solo
                        if (nombreTarea.isNotEmpty) {
                          bool isDuplicado =
                              await _isNombreTareaDuplicado(nombreTarea);
                          if (isDuplicado) {
                            // Mostrar un diálogo indicando que el nombre ya existe
                            showAlertRepetido(context, 2);
                          } else {
                            Navigator.of(context).pushReplacement(
                                buildFadeRoute(CreaTareaDosView(
                              nombreTarea: nombreTarea,
                              objectiveRef: widget.objectiveRef,
                            )));
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
