import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/tareas_showdialog.dart';

Widget tareasContainer(BuildContext context) => GestureDetector(
      onTap: () => showAlertTareas(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(CupertinoIcons.pencil_circle_fill),
                color: const Color(0xFFFEFCEE),
                onPressed: () {
                  showAlertTareas(context);
                },
              ),
              Text("Tareas",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFEFCEE),
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("Qué tengo que hacer para conseguir mi objetivo.",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(151, 254, 252, 238),
                  )),
            ),
          ],
        ),
      ),
    );
