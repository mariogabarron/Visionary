import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/porque_showdialog.dart';

Widget porqueContainer(context) => GestureDetector(
      onTap: () => showAlertPorque(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(CupertinoIcons.pencil_circle_fill),
                color: const Color(0xFFFEFCEE),
                onPressed: () {
                  showAlertPorque(context);
                },
              ),
              Text("¿Por qué lo hago?",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFEFCEE),
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Escribe la razón de por qué quieres cumplir este objetivo.",
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(151, 254, 252, 238),
                ),
              ),
            ),
          ],
        ),
      ),
    );
