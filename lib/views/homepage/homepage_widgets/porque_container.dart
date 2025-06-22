import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/utilities/showdialogs/homepage/porque_showdialog.dart';

class PorqueLoHagoContainer extends StatefulWidget {
  final String objetivo;
  final VoidCallback onTaskUpdated;
  const PorqueLoHagoContainer(
      {super.key, required this.objetivo, required this.onTaskUpdated});

  @override
  State<PorqueLoHagoContainer> createState() => _PorqueLoHagoContainerState();
}

class _PorqueLoHagoContainerState extends State<PorqueLoHagoContainer> {
  bool _isDialogOpen = false;
  bool _isExpanded = false;
  double _bottomPadding = 8;

  Future<String?>? _propositoFuture;

  @override
  void initState() {
    super.initState();
    _propositoFuture = _loadProposito();
  }

  @override
  void didUpdateWidget(covariant PorqueLoHagoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.objetivo != widget.objetivo) {
      setState(() {
        _propositoFuture = _loadProposito();
      });
    }
  }

  void _refreshProposito() {
    setState(() {
      _propositoFuture = _loadProposito();
    });
  }

  Future<String?> _loadProposito() async {
    try {
      final objetivoRef = FirebaseDatabase.instance.ref(widget.objetivo);
      final objetivo = await Objetivo.fromRef(objetivoRef);
      return objetivo.motive ?? "No se especificó un propósito.";
    } catch (e) {
      return "No se pudo cargar el propósito.";
    }
  }

  void _expandBottomPadding() {
    setState(() {
      _isExpanded = !_isExpanded;
      _bottomPadding = _bottomPadding == 8 ? 35 : 8; // Alternar entre 8 y 35
    });
  }

  String splitTextByWords(String text, int limit) {
    List<String> words = text.split(' ');
    if (words.length <= limit) return text;

    // ignore: prefer_interpolation_to_compose_strings
    return words.take(limit).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Elimina el onTap general para que solo el botón abra el diálogo
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
                  filter:
                      ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0), // Más blur
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                          0.15), // Más opaco para resaltar el efecto
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white.withOpacity(
                            0.18), // Borde sutil blanco translúcido
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
                                        CupertinoIcons.pencil_circle_fill,
                                        size: 22),
                                    color: const Color(0xFFFEFCEE),
                                    onPressed: () {
                                      if (_isDialogOpen) return;
                                      setState(() {
                                        _isDialogOpen = true;
                                      });
                                      showAlertPorque(context, widget.objetivo,
                                          () {
                                        _refreshProposito();
                                        widget.onTaskUpdated();
                                      });
                                      setState(() {
                                        _isDialogOpen = false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  "Propósito",
                                  style: GoogleFonts.kantumruyPro(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFEFCEE),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  FutureBuilder<String?>(
                                    future: _propositoFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Indicador de carga personalizado (reloj de arena)
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.hourglass,
                                              color: const Color.fromARGB(
                                                  151, 254, 252, 238),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Cargando propósito...",
                                              style: GoogleFonts.kantumruyPro(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: const Color.fromARGB(
                                                    151, 254, 252, 238),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          "Error al cargar el propósito.",
                                          style: GoogleFonts.kantumruyPro(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: const Color.fromARGB(
                                                151, 254, 252, 238),
                                          ),
                                        );
                                      } else {
                                        // Texto predeterminado si no hay propósito
                                        String fullText = snapshot
                                                    .data?.isNotEmpty ==
                                                true
                                            ? snapshot.data!
                                            : "Introduce aquí el propósito de tu objetivo.";
                                        String displayedText = _isExpanded
                                            ? fullText
                                            : splitTextByWords(fullText, 80);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              displayedText,
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFFEFCEE),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            if (fullText.split(' ').length > 80)
                                              Center(
                                                child: IconButton(
                                                  icon: Icon(
                                                    _isExpanded
                                                        ? CupertinoIcons
                                                            .chevron_up
                                                        : CupertinoIcons
                                                            .chevron_down,
                                                    color:
                                                        const Color(0xFFFEFCEE),
                                                  ),
                                                  onPressed:
                                                      _expandBottomPadding,
                                                ),
                                              )
                                            else
                                              const SizedBox(
                                                  height:
                                                      10), // Margen si no hay botón de expandir
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            AnimatedPadding(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.only(
                                  bottom: _isExpanded ? 0 : _bottomPadding),
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
