import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/progreso_showdialog.dart';
import 'package:visionary/utilities/progressbar.dart';

Widget progresoContainer(
        {required BuildContext context, required double porcentaje}) =>
    GestureDetector(
      onTap: () => showAlertProgreso(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
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
            const SizedBox(height: 12),
            ProgressBar(porcentaje: porcentaje),
          ],
        ),
      ),
    );
