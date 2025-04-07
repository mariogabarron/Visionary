import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/utilities/showdialogs/homepage/porque_showdialog.dart';

class PorqueLoHagoContainer extends StatefulWidget {
  final String objetivo;
  const PorqueLoHagoContainer({super.key, required this.objetivo});

  @override
  State<PorqueLoHagoContainer> createState() => _PorqueLoHagoContainerState();
}

class _PorqueLoHagoContainerState extends State<PorqueLoHagoContainer> {
  bool _isDialogOpen = false;
  String? _proposito;

  @override
  void initState() {
    super.initState();
    _loadProposito(); // Cargar el propósito al inicializar
  }

  Future<void> _loadProposito() async {
    // Simula la obtención del propósito desde la base de datos o lógica
    // Reemplaza esto con tu lógica real para obtener el propósito
    final proposito = await Future.delayed(
      const Duration(milliseconds: 500),
      () => "Este es un ejemplo de propósito.", // Ejemplo de propósito
    );

    setState(() {
      _proposito = proposito; // Actualiza el propósito
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isDialogOpen) {
          return; //  Impedir que se abra el diálogo si ya está abierto
        }

        setState(() {
          _isDialogOpen = true; // Marcar el diálogo como abierto
        });

        showAlertPorque(context, widget.objetivo);

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
                            left: 15.0, right: 15.0, top: 10, bottom: 10),
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
                                    onPressed: () {
                                      showAlertPorque(context, widget.objetivo);
                                    },
                                  ),
                                ),
                                Text(
                                  "Propósito",
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
                              child: Text(
                                _proposito ??
                                    "Escribe la razón por la que se quiere cumplir este objetivo.",
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color:
                                      const Color.fromARGB(151, 254, 252, 238),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Utiliza AnimatedPadding para animar el cambio de padding inferior
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
