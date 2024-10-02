import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/tareas_showdialog.dart';

Widget tareasContainer(BuildContext context) => GestureDetector(
      onTap: () => showAlertTareas(context),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 100, top: 8),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
