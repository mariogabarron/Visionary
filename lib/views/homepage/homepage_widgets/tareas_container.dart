import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/utilities/showdialogs/homepage/editartarea_showdialog.dart';
import 'package:visionary/utilities/showdialogs/homepage/tareas_showdialog.dart';

class TareasContainer extends StatefulWidget {
  final String objetivo;
  const TareasContainer({super.key, required this.objetivo});

  @override
  State<TareasContainer> createState() => _TareasContainerState();
}

class _TareasContainerState extends State<TareasContainer> {
  late TextEditingController editingController;
  double _bottomPadding = 8;
  bool _isExpanded = false;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    editingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    editingController.dispose();
  }

  void _expandBottomPadding() {
    setState(() {
      _isExpanded = !_isExpanded;
      _bottomPadding = _bottomPadding == 8 ? 35 : 8; // Alternar entre 10 y 100
    });
  }

  DatabaseReference getRef() {
    return FirebaseDatabase.instance.ref(widget.objetivo);
  }

  Future<Objetivo> getObjetivo() async {
    return await Objetivo.fromRef(getRef());
  }

  Future<List<Tarea>> getListaTareas() async {
    Objetivo o = await getObjetivo();
    return o.listaTareas;
  }

  String splitTextBySpaces(String text, int limit) {
    List<String> words = text.split(' ');
    StringBuffer buffer = StringBuffer();
    String line = '';

    for (String word in words) {
      if ((line + word).length > limit) {
        buffer.write('${line.trim()}\n');
        line = '';
      }
      line += '$word ';
    }

    if (line.isNotEmpty) {
      buffer.write(line.trim());
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_isDialogOpen) {
          return; // Evitar abrir múltiples diálogos
        }

        setState(() {
          _isDialogOpen = true; // Marca que hay un diálogo abierto
        });

        List<Tarea> tareas = await getListaTareas();

        if (context.mounted) showAlertTareas(context, widget.objetivo, tareas);

        setState(() {
          _isDialogOpen = false; // Marcar el diálogo como cerrado
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Para que la sombra sea circular
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFEFCEE)
                                            .withOpacity(
                                                0.15), // Color de la sombra
                                        spreadRadius:
                                            3, // Qué tanto se expande la sombra
                                        blurRadius:
                                            20, // Desenfoque de la sombra
                                        offset: const Offset(0,
                                            0), // Desplazamiento de la sombra (x, y)
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                        CupertinoIcons.pencil_circle_fill),
                                    color: const Color(0xFFFEFCEE),
                                    onPressed: () async {
                                      List<Tarea> tareas =
                                          await getListaTareas();
                                      showAlertTareas(
                                          context, widget.objetivo, tareas);
                                    },
                                  ),
                                ),
                                Text(
                                  "Tareas",
                                  style: GoogleFonts.poppins(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFEFCEE),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Qué tengo que hacer para conseguir mi objetivo.",
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: const Color.fromARGB(
                                          151, 254, 252, 238),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Utiliza AnimatedPadding para animar el cambio de padding inferior
                            AnimatedPadding(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.only(bottom: _bottomPadding),
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _isExpanded
                                          ? CupertinoIcons.chevron_up
                                          : CupertinoIcons.chevron_down,
                                      color: const Color(0xFFFEFCEE),
                                    ),
                                    onPressed: _expandBottomPadding,
                                  ),
                                  if (_isExpanded)
                                    FutureBuilder<List<Tarea>>(
                                      future: getListaTareas(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 20),
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color(0xFFFEFCEE)),
                                                strokeWidth: 3.0,
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            "Error: ${snapshot.error}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          );
                                        } else if (snapshot.hasData &&
                                            snapshot.data!.isNotEmpty) {
                                          // Agrega estado inicial de completado para cada tarea
                                          List<bool> completed = List.generate(
                                              snapshot.data!.length,
                                              (index) => false);

                                          return Column(
                                            children: List.generate(
                                              snapshot.data!.length,
                                              (index) => Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      completed[index]
                                                          ? CupertinoIcons
                                                              .check_mark_circled_solid
                                                          : CupertinoIcons
                                                              .circle,
                                                      color: const Color(
                                                          0xFFFEFCEE),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        completed[index] =
                                                            !completed[index];
                                                      });
                                                    },
                                                  ),
                                                  GestureDetector(
                                                    onLongPress: () {
                                                      showAlertBottomEditarTarea(
                                                          context,
                                                          snapshot.data![index]
                                                              .dbRef,
                                                          snapshot.data![index]
                                                              .name,
                                                          editingController);
                                                      print(
                                                          "Texto mantenido: ${snapshot.data![index].name}");
                                                    },
                                                    child: Text(
                                                      splitTextBySpaces(
                                                          snapshot.data![index]
                                                              .name,
                                                          20),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xFFFEFCEE),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            "No hay tareas disponibles.",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: const Color(0xFFFEFCEE),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                ],
                              ),
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
  }
}
