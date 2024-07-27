import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> _listaFrases = [
  "\"Si fallas al planear, planeas fallar\"",
  "\"La mejor manera de predecir el futuro es crearlo\"",
  "\"Un objetivo sin un plan es solo un deseo\"",
  "\"Si no sabes a dónde vas, cualquier camino te llevará allí\"",
  "\"El futuro pertenece a quienes lo planifican\"",
  "\"Un buen plan es la mitad del trabajo\"",
  "\"El miedo al fracaso es peor que el fracaso en sí\"",
  "\"No hay mejor momento que el presente\"",
];

final random = Random();
int numeroAleatorio = random.nextInt(8);

Widget fraseContainer() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Text(_listaFrases[numeroAleatorio],
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
    );
