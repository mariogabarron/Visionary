import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/utilities/showdialogs/homepage/editarobjetivo_showdialog.dart';

Widget objetivosRow() => ObjetivosRow();

class ObjetivosRow extends StatelessWidget {
  final List<String> _objetivos = [
    'Deporte',
    'Uni',
    'Trabajo',
    'Hogar',
    'Viajes',
    'Salud',
    'Estudio',
    'Familia',
    'Pareja'
  ];

  ObjetivosRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ClipRect(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.transparent,
                Colors.white,
                Colors.white,
                Colors.transparent,
              ],
              stops: [0.0, 0.1, 0.9, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var objetivo in _objetivos)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: () =>
                              showAlertBottomEditarObjetivo(context, objetivo),
                          child: Text(
                            objetivo,
                            style: const TextStyle(
                              color: Color.fromARGB(201, 254, 252, 238),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(crearObjetivoUno);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEFCEE).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text('Añadir objetivo',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFFEFCEE),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
