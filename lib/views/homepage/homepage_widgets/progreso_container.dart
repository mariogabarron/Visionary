import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/progreso_showdialog.dart';
import 'package:visionary/utilities/progressbar.dart';

Widget progresoContainer(
        {required BuildContext context, required double porcentaje}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      child: Column(
        children: [
          Row(children: [
            IconButton(
              icon: const Icon(CupertinoIcons.pencil_circle_fill),
              color: const Color(0xFFFEFCEE),
              onPressed: () {
                showAlertProgreso(context);
              },
            ),
            Text("Progreso",
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFEFCEE),
                )),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Cada 1% te acerca un poco más al resultado.",
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(151, 254, 252, 238),
                )),
          ),
          const SizedBox(height: 15),
          ProgressBar(porcentaje: porcentaje),
        ],
      ),
    );
