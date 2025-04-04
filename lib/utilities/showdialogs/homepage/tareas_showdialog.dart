import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareauno_view.dart';

void showAlertTareas(
    BuildContext context, String objectiveRef, List<Tarea> tareas) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFEFCEE),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                'Tareas',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: const Color(0xFF26272C),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Edita tus tareas en el desplegable\n del menú principal',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: const Color.fromARGB(183, 40, 40, 40),
                ),
              ),
              const SizedBox(height: 50),
              if (tareas.isEmpty)
                Text(
                  'No has creado aún tareas',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                )
              else
                Column(
                  children: [
                    ...tareas.take(3).map((tarea) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "${tarea.name} (${tarea.timesDone}/${tarea.needDone})",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: const Color(0xFF26272C),
                          ),
                        ),
                      );
                    }),
                    if (tareas.length > 3)
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26272C),
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D97AC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(buildFadeRoute(
                          CreaTareaUnoView(objectiveRef: objectiveRef)));
                    },
                    child: Text(
                      'Crear tarea',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFEFCEE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Continuar',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}
