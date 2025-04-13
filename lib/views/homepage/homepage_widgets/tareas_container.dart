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
  double _bottomPadding = 8;
  bool _isExpanded = false;
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
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFEFCEE)
                                          .withOpacity(0.15),
                                      spreadRadius: 3,
                                      blurRadius: 20,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.add_circled_solid),
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
                                      Navigator.of(context).pushReplacement(
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
                                  "Crea, edita y completa aquí tus tareas",
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
                                            child: CustomLoader(),
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
                                        snapshot.data!.sort((a, b) =>
                                            b.priority.compareTo(a.priority));

                                        // ...existing code...

                                        return Column(
                                          children: List.generate(
                                            snapshot.data!.length,
                                            (index) {
                                              Tarea tarea =
                                                  snapshot.data![index];
                                              return Row(
                                                children: [
                                                  AnimatedOpacity(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    opacity: tarea.timesDone ==
                                                            tarea.needDone
                                                        ? 0.5
                                                        : 1.0, // Cambiar opacidad solo si timesDone == needDone
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            tarea.isDone()
                                                                ? CupertinoIcons
                                                                    .check_mark_circled_solid
                                                                : CupertinoIcons
                                                                    .circle,
                                                            color: const Color(
                                                                0xFFFEFCEE),
                                                          ),
                                                          onPressed: () async {
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

                                                              // Notificar que la tarea ha sido actualizada
                                                              widget
                                                                  .onTaskUpdated();
                                                            } catch (e) {
                                                              log("Error al completar la tarea: $e");
                                                            }
                                                          },
                                                        ),
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
                                                            "${splitTextBySpaces(tarea.name, 20)}"
                                                            "${tarea.needDone > 1 ? " (${tarea.timesDone}/${tarea.needDone})" : ""}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xFFFEFCEE),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (tarea.needDone > 1 &&
                                                      tarea.timesDone > 0 &&
                                                      tarea.needDone !=
                                                          tarea.timesDone)
                                                    IconButton(
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .minus_circle,
                                                        color:
                                                            Color(0xFFFEFCEE),
                                                      ),
                                                      onPressed: () async {
                                                        try {
                                                          tarea.makeUndone();

                                                          widget
                                                              .onTaskUpdated();

                                                          setState(() {
                                                            getListaTareas();
                                                          });
                                                        } catch (e) {
                                                          log("Error al reducir la tarea: $e");
                                                        }
                                                      },
                                                    ),
                                                ],
                                              );
                                            },
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
    );
  }
}
