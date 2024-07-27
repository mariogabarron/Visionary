import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/homepage_widgets/frase_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/objetivos_row.dart';
import 'package:visionary/views/homepage/homepage_widgets/porque_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/progreso_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/tareas_container.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
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
          title: Stack(
            children: [
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.gear_solid),
                  color: const Color(0xFFFEFCEE),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(ajustesCuenta);
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
              colors: [Color(0xFF6D97AC), Color(0xFFF6D0B1)],
              transform: GradientRotation(88 * pi / 180),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                objetivosRow(),
                const SizedBox(height: 10),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  child: Divider(color: Color(0xFFFEFCEE)),
                ),
                const SizedBox(height: 15),
                tareasContainer(context),
                const SizedBox(height: 50),
                porqueContainer(context),
                const SizedBox(height: 50),
                progresoContainer(context: context, porcentaje: 0.4),
                const SizedBox(height: 50),
                fraseContainer(),
              ],
            ),
          ),
        ));
  }
}
