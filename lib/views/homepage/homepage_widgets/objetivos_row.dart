import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/visionaryUser_class.dart';
import 'package:visionary/utilities/showdialogs/homepage/editarobjetivo_showdialog.dart';

class ObjetivosRow extends StatefulWidget {
  const ObjetivosRow({super.key});

  @override
  State<ObjetivosRow> createState() => _ObjetivosRowState();
}

class _ObjetivosRowState extends State<ObjetivosRow> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VisionaryUser>(
      future: VisionaryUser.fromLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          final objectives = user.objectives;

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
                      for (var objetivo in objectives)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onLongPress: () async {
                                  Objetivo obj =
                                      await Objetivo.fromRef(objetivo.$2);
                                  if (context.mounted) {
                                    showAlertBottomEditarObjetivo(
                                        context, obj, controller);
                                  }
                                },
                                child: Text(
                                  objetivo.$1,
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
                        onPressed: () async {
                          if (context.mounted) {
                            Navigator.of(context)
                                .pushReplacementNamed(crearObjetivoUno);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFEFCEE).withOpacity(0.2),
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
        } else {
          return const Text('ERROR AL CARGAR');
        }
      },
    );
  }
}
