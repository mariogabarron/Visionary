import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/recordatorio.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareados_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareascuatro_view.dart';
import 'package:visionary/views/homepage/homepage_view.dart'; // Importa para reutilizar el fondo

import '../../../services/objects/tarea_class.dart';

class CreaTareaTresView extends StatefulWidget {
  final String nombreTarea;
  final int prioridad;
  final String objectiveRef;

  const CreaTareaTresView(
      {super.key,
      required this.nombreTarea,
      required this.prioridad,
      required this.objectiveRef});

  @override
  State<CreaTareaTresView> createState() => _CreaTareaTresViewState();
}

class _CreaTareaTresViewState extends State<CreaTareaTresView> {
  int _selectedFrequency = 1;
  int _selectedRepeticiones = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFFFEFCEE),
        ),
        title: Text(
          'Visionary.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontSize: 30,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 0, 0), // Fondo oscuro
          ),
          _AnimatedBackground(
            circles: [
              _CircleData(
                color: const Color(0xFF6D97AC).withOpacity(0.32),
                radius: 220,
                dx: -0.5,
                dy: -0.6,
                vx: 0.008,
                vy: 0.006,
              ),
              _CircleData(
                color:
                    const Color.fromARGB(255, 212, 176, 146).withOpacity(0.22),
                radius: 180,
                dx: 0.6,
                dy: -0.4,
                vx: -0.006,
                vy: 0.007,
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    '¿Quieres que tu tarea se repita?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    String label;
                    switch (index) {
                      case 0:
                        label = 'Se repite';
                        break;
                      case 1:
                        label = 'No se repite';
                        break;
                      default:
                        label = '';
                    }
                    final bool selected = _selectedFrequency == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFrequency = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: selected
                              ? const Color(0xFF6D97AC).withOpacity(0.32)
                              : Colors.grey[300],
                          border: selected
                              ? Border.all(
                                  color:
                                      const Color(0xFFFEFCEE).withOpacity(0.18),
                                  width: 2.0,
                                )
                              : null,
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF6D97AC)
                                        .withOpacity(0.08),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 6),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.poppins(
                            color: selected
                                ? const Color(0xFFFEFCEE)
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                _selectedFrequency == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_selectedRepeticiones > 1) {
                                        _selectedRepeticiones--;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                      CupertinoIcons.minus_circle_fill),
                                  color: Colors.white,
                                  iconSize: 25,
                                ),
                                Text(
                                  '$_selectedRepeticiones',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedRepeticiones++;
                                    });
                                  },
                                  icon: const Icon(
                                      CupertinoIcons.add_circled_solid),
                                  color: Colors.white,
                                  iconSize: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    _selectedFrequency == 0
                        ? "Selecciona el total de veces que debes de cumplir esta tarea para darla por finalizada."
                        : _selectedFrequency == 1
                            ? "Tu tarea sólo se debe cumplir una vez para finalizarse."
                            : "Selecciona \"Se repite\" si tu tarea se debe cumplir más de una vez para darse por finalizada.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(buildFadeRoute(
                              CreaTareaDosView(
                                  nombreTarea: widget.nombreTarea,
                                  objectiveRef: widget.objectiveRef)));
                        },
                      ),
                    ),
                    const SizedBox(width: 20), // Espaciado entre botones
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: () {
                          // TODO: Implementar la lógica para crear el recordatorio
                          Tarea t = Tarea(widget.objectiveRef,
                              name: widget.nombreTarea,
                              priority: widget.prioridad,
                              needDone: _selectedRepeticiones,
                              recordatorio: Recordatorio(
                                  tipoRecordatorio: TipoRecordatorio.semanal,
                                  hora: (0, 0),
                                  codigo: "LMXJV"));
                          t.update();
                          Navigator.of(context)
                              .pushReplacementNamed(tareaCreadaView);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
  final List<_CircleData> circles;

  const _AnimatedBackground({super.key, required this.circles});

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_CircleData> _circles;

  @override
  void initState() {
    super.initState();
    _circles = widget.circles.map((c) => _CircleData.clone(c)).toList();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, int index, Size size) {
    setState(() {
      final dx = (details.localPosition.dx / size.width) * 2 - 1;
      final dy = (details.localPosition.dy / size.height) * 2 - 1;
      _circles[index].dx = dx.clamp(-1.0, 1.0);
      _circles[index].dy = dy.clamp(-1.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            for (final c in _circles) {
              c.dx += c.vx * 0.8;
              c.dy += c.vy * 0.8;
              if (c.dx > 1.0 || c.dx < -1.0) c.vx = -c.vx;
              if (c.dy > 1.0 || c.dy < -1.0) c.vy = -c.vy;
              c.dx = c.dx.clamp(-1.0, 1.0);
              c.dy = c.dy.clamp(-1.0, 1.0);
            }
            return Stack(
              children: [
                for (int i = 0; i < _circles.length; i++)
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanUpdate: (details) => _onPanUpdate(details, i, size),
                      child: CustomPaint(
                        painter: _CirclePainter(_circles[i], size),
                        isComplex: false,
                        willChange: true,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _CircleData {
  Color color;
  double radius;
  double dx, dy;
  double vx, vy;
  _CircleData({
    required this.color,
    required this.radius,
    required this.dx,
    required this.dy,
    required this.vx,
    required this.vy,
  });

  static _CircleData clone(_CircleData c) => _CircleData(
        color: c.color,
        radius: c.radius,
        dx: c.dx,
        dy: c.dy,
        vx: c.vx,
        vy: c.vy,
      );
}

class _CirclePainter extends CustomPainter {
  final _CircleData circle;
  final Size size;
  _CirclePainter(this.circle, this.size);

  @override
  void paint(Canvas canvas, Size _) {
    final center = Offset(
      size.width / 2 + circle.dx * size.width / 2,
      size.height / 2 + circle.dy * size.height / 2,
    );
    final paint = Paint()
      ..color = circle.color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    canvas.drawCircle(center, circle.radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) =>
      oldDelegate.circle != circle || oldDelegate.size != size;
}
