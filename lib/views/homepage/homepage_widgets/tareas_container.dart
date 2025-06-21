import 'dart:developer';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/utilities/animations/customloader.dart';
import 'package:visionary/utilities/showdialogs/homepage/editartarea_showdialog.dart';
// QUITAMOS EL IMPORT DE TAREAS_SHOWDIALOG
// import 'package:visionary/utilities/showdialogs/homepage/tareas_showdialog.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareauno_view.dart'; // Import the file where CreaTareaUnoView is defined

class TareasContainer extends StatefulWidget {
  final String objetivo;
  final VoidCallback onTaskUpdated; // Callback para notificar cambios
  const TareasContainer(
      {super.key, required this.objetivo, required this.onTaskUpdated});

  @override
  State<TareasContainer> createState() => _TareasContainerState();
}

class _TareasContainerState extends State<TareasContainer> {
  late TextEditingController editingController;
  double _bottomPadding =
      35; // Cambiado a 35 para estar desplegado inicialmente
  bool _isExpanded = true; // Cambiado a true para estar desplegado inicialmente
  bool _isDialogOpen = false;

  // Mapa para rastrear las tareas completadas y su animación
  Map<String, bool> completedTasks = {};

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
    return Stack(
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
                filter:
                    ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0), // Más blur
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.15), // Más opaco para resaltar el efecto
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white
                          .withOpacity(0.18), // Borde sutil blanco translúcido
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
                                  shape: BoxShape.circle,
                                  /*boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFEFCEE)
                                          .withOpacity(0.15),
                                      spreadRadius: 3,
                                      blurRadius: 20,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],*/
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.add_circled_solid,
                                      size: 22),
                                  color: const Color(0xFFFEFCEE),
                                  onPressed: () async {
                                    if (_isDialogOpen) {
                                      return;
                                    }

                                    setState(() {
                                      _isDialogOpen = true;
                                    });

                                    await getListaTareas();

                                    if (context.mounted) {
                                      Navigator.of(context).push(
                                          buildFadeRoute(CreaTareaUnoView(
                                              objectiveRef: widget.objetivo)));
                                    }

                                    setState(() {
                                      _isDialogOpen = false;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Tareas",
                                style: GoogleFonts.kantumruyPro(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFEFCEE),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0.05), // Menos espacio aquí
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calcula el padding izquierdo proporcional al ancho de la pantalla
                              double leftPadding = constraints.maxWidth * 0.03;
                              // Mínimo 8, máximo 20 para que no se desplace demasiado en pantallas grandes/pequeñas
                              leftPadding = leftPadding.clamp(8.0, 20.0);
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: leftPadding, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Crea, edita y completa aquí tus tareas",
                                      style: GoogleFonts.kantumruyPro(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: const Color.fromARGB(
                                            151, 254, 252, 238),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 150),
                            padding: EdgeInsets.only(bottom: _bottomPadding),
                            child: FutureBuilder<List<Tarea>>(
                              future: getListaTareas(),
                              builder: (context, snapshot) {
                                final tareas = snapshot.data ?? [];
                                final showExpand = tareas.length >= 4;
                                return Column(
                                  children: [
                                    if (showExpand)
                                      IconButton(
                                        icon: Icon(
                                          _isExpanded
                                              ? CupertinoIcons.chevron_up
                                              : CupertinoIcons.chevron_down,
                                          color: const Color(0xFFFEFCEE),
                                        ),
                                        onPressed: _expandBottomPadding,
                                      ),
                                    if (!showExpand)
                                      const SizedBox(
                                          height:
                                              15), // Espacio extra si hay menos de 6 tareas
                                    if (_isExpanded || !showExpand)
                                      Builder(
                                        builder: (context) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: CustomLoader(),
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                              "Error: ${snapshot.error}",
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            );
                                          } else if (tareas.isNotEmpty) {
                                            tareas.sort((a, b) => b.priority
                                                .compareTo(a.priority));
                                            return Column(
                                              children: List.generate(
                                                tareas.length,
                                                (index) {
                                                  Tarea tarea = tareas[index];
                                                  final bool done =
                                                      tarea.isDone();
                                                  Widget taskTitleWithDelete =
                                                      Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onLongPress: () {
                                                          showAlertBottomEditarTarea(
                                                            context,
                                                            tarea.dbRef,
                                                            tarea.name,
                                                            editingController,
                                                            widget
                                                                .onTaskUpdated,
                                                          );
                                                        },
                                                        child: Text(
                                                          "${splitTextBySpaces(tarea.name, 20)} ",
                                                          style: GoogleFonts
                                                              .kantumruyPro(
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xFFFEFCEE),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      if (done)
                                                        GestureDetector(
                                                          onTap: () async {
                                                            try {
                                                              await tarea
                                                                  .deleteTask();
                                                              widget
                                                                  .onTaskUpdated();
                                                              setState(() {
                                                                getListaTareas();
                                                              });
                                                            } catch (e) {
                                                              log("Error al eliminar la tarea: $e");
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 4.0),
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .trash,
                                                              color: Color(
                                                                  0xFFFEFCEE),
                                                              size: 17,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                  if (tarea.needDone > 1) {
                                                    // Controlador tipo stepper para tareas múltiples
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 8),
                                                          Container(
                                                            width: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      42,
                                                                      254,
                                                                      252,
                                                                      238),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        1,
                                                                    vertical:
                                                                        2),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    try {
                                                                      tarea
                                                                          .makeUndone();
                                                                      widget
                                                                          .onTaskUpdated();
                                                                      setState(
                                                                          () {
                                                                        getListaTareas();
                                                                      });
                                                                    } catch (e) {
                                                                      log("Error al reducir la tarea: $e");
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            2.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Color(
                                                                          0xFFFEFCEE),
                                                                      size: 17,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                                  child: Text(
                                                                    "${tarea.timesDone}",
                                                                    style: GoogleFonts
                                                                        .kantumruyPro(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFFFEFCEE),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    try {
                                                                      tarea
                                                                          .makeDone();
                                                                      widget
                                                                          .onTaskUpdated();
                                                                      setState(
                                                                          () {
                                                                        getListaTareas();
                                                                      });
                                                                    } catch (e) {
                                                                      log("Error al aumentar la tarea: $e");
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Color(
                                                                          0xFFFEFCEE),
                                                                      size: 17,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  taskTitleWithDelete,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 40),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    // Tareas normales (solo se hacen una vez): papelera justo a la derecha del título
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 8),
                                                          Container(
                                                            width: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      42,
                                                                      254,
                                                                      252,
                                                                      238),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        1,
                                                                    vertical:
                                                                        2),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                try {
                                                                  setState(() {
                                                                    if (!tarea
                                                                        .isDone()) {
                                                                      tarea
                                                                          .makeDone();
                                                                    } else {
                                                                      tarea
                                                                          .makeUndone();
                                                                    }
                                                                  });
                                                                  widget
                                                                      .onTaskUpdated();
                                                                } catch (e) {
                                                                  log("Error al completar la tarea: $e");
                                                                }
                                                              },
                                                              child: Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0,
                                                                      vertical:
                                                                          0.0),
                                                                  child: Icon(
                                                                    tarea.isDone()
                                                                        ? CupertinoIcons
                                                                            .check_mark_circled_solid
                                                                        : CupertinoIcons
                                                                            .circle,
                                                                    color: const Color(
                                                                        0xFFFEFCEE),
                                                                    size: 17,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  taskTitleWithDelete,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                "Crea tu primera tarea.",
                                                style: GoogleFonts.kantumruyPro(
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xFFFEFCEE),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                  ],
                                );
                              },
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
    );
  }
}
