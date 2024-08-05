import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/utilities/buildinputfield.dart';

class CrearObjetivoDosView extends StatefulWidget {
  const CrearObjetivoDosView({super.key});

  @override
  State<CrearObjetivoDosView> createState() => _CrearObjetivoDosViewState();
}

class _CrearObjetivoDosViewState extends State<CrearObjetivoDosView>
    with SingleTickerProviderStateMixin {
  late TextEditingController _porqueTareaEditingController;
  @override
  void initState() {
    _porqueTareaEditingController = TextEditingController();
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _porqueTareaEditingController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  final _random = Random();
  int _numeroAleatorio = 0;
  Timer? _timer;
  bool _isFirstTime = true;
  final List<String> _listaTextoBelowTextField = [
    "¿Qué/quién te inspira para cumplir esta meta?",
    "¿Qué te beneficiará cuando cumplas este objetivo?",
    "¿Desde cuando llevas soñando con cumplir este objetivo?",
    "¿Por qué empezaste a mostrar interés por cumplir esta meta?",
    "¿Cuál es el valor más importante que obtendrás al alcanzar este objetivo?",
    "¿Qué temores o inseguridades estás buscando superar con este objetivo?",
    "¿Cómo crees que este objetivo cambiará tu vida a largo plazo?",
    "¿Qué legado quieres dejar al cumplir este objetivo?",
    "¿Qué obstáculos crees que encontrarás en el camino y cómo planeas superarlos?",
  ];

  void _startTimer() {
    const duration = Duration(seconds: 2);
    _timer = Timer.periodic(duration, (timer) async {
      if (_isFirstTime) {
        _isFirstTime = false; // Desmarcar para futuras ejecuciones
        return;
      }
      setState(() {
        _numeroAleatorio = _random.nextInt(4);
      });
    });
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
              transform: GradientRotation(88 * pi / 180)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text('¿Por qué quieres cumplir este objetivo?',
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
                hintText: "Cuéntanos...",
                controller: _porqueTareaEditingController,
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(_listaTextoBelowTextField[_numeroAleatorio],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 233, 232, 220),
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ))),
              const SizedBox(height: 20),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(homepageView);
                  },
                  icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                  color: const Color(0xFFFEFCEE))
            ],
          ),
        ),
      ),
    );
  }
}
