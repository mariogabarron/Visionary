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
  bool _isExpanded = false; // Controla si el texto está expandido o contraído
  double _bottomPadding = 8;

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

    return words.take(limit).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isDialogOpen) return;

        setState(() {
          _isDialogOpen = true;
        });

        showAlertPorque(context, widget.objetivo, () {
          setState(() {});
          widget.onTaskUpdated();
        });

        setState(() {
          _isDialogOpen = false;
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
                                      showAlertPorque(context, widget.objetivo,
                                          () {
                                        setState(() {});
                                        widget.onTaskUpdated();
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Propósito",
                                  style: GoogleFonts.poppins(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
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
                                    future: _loadProposito(),
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
                                              style: GoogleFonts.poppins(
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
                                          style: GoogleFonts.poppins(
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
                                            : splitTextByWords(fullText, 20);

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Alinear texto a la izquierda
                                          children: [
                                            Text(
                                              displayedText,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    179, 254, 252, 238),
                                              ),
                                              textAlign: TextAlign
                                                  .left, // Alinear texto a la izquierda
                                            ),
                                            if (fullText.split(' ').length > 20)
                                              Center(
                                                // Centrar el botón
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
                                              ),
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
                              padding: EdgeInsets.only(bottom: _bottomPadding),
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
