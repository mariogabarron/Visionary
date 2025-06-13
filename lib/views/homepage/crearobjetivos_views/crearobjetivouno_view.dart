import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';
import 'package:visionary/utilities/buildinputfield.dart';
import 'package:visionary/utilities/showdialogs/objetivovacio_showdialog.dart';
import 'package:visionary/utilities/showdialogs/repetido_showdialog.dart';
import 'package:visionary/views/homepage/crearobjetivos_views/crearobjetivodos_view.dart';

class CrearObjetivoUnoView extends StatefulWidget {
  const CrearObjetivoUnoView({super.key});
  @override
  State<CrearObjetivoUnoView> createState() => _CrearObjetivoUnoViewState();
}

class _CrearObjetivoUnoViewState extends State<CrearObjetivoUnoView> {
  late TextEditingController _nombreObjetivoEditingController;
  @override
  void initState() {
    _nombreObjetivoEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nombreObjetivoEditingController.dispose();
    super.dispose();
  }

  Future<bool> _isNombreObjetivoDuplicado(String nombre) async {
    VisionaryUser user = await VisionaryUser.fromLogin();
    List<String> nombresObjetivos =
        user.objectives.map((objetivo) => objetivo.$1).toList();
    return nombresObjetivos.any((nombreExistente) =>
        nombreExistente.toLowerCase() == nombre.toLowerCase());
  }

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
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0), // Baja un poco el título
          child: Text(
            'Visionary.',
            textAlign: TextAlign.center,
            style: GoogleFonts.kantumruyPro(
              color: const Color(0xFFFEFCEE),
              fontSize: 27,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
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
                  child: Text('¿Cúal es el objetivo que te gustaría cumplir?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kantumruyPro(
                        color: const Color(0xFFFEFCEE),
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                buildInputField(
                    label: "",
                    inputType: TextInputType.name,
                    hintText: "Escríbelo en una palabra",
                    controller: _nombreObjetivoEditingController,
                    maxWords: 16),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text('Podrás modificarlo más tarde',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kantumruyPro(
                          color: const Color.fromARGB(255, 233, 232, 220),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                        ))),
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
                          Navigator.of(context)
                              .pushReplacementNamed(homepageView);
                        },
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        null,
                        color: Color(0xFFFEFCEE),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Color(0xFFFEFCEE),
                        ),
                        onPressed: () async {
                          String nuevoNombre =
                              _nombreObjetivoEditingController.text.trim();
                          nuevoNombre =
                              nuevoNombre.replaceAll(RegExp(r'\s+'), ' ');
                          // Capitaliza la primera letra
                          if (nuevoNombre.isNotEmpty) {
                            nuevoNombre = nuevoNombre[0].toUpperCase() +
                                nuevoNombre.substring(1);
                          }

                          if (nuevoNombre.isNotEmpty) {
                            bool isDuplicado =
                                await _isNombreObjetivoDuplicado(nuevoNombre);
                            if (isDuplicado) {
                              if (context.mounted) {
                                showAlertRepetido(context, 1);
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                  buildFadeRoute(CrearObjetivoDosView(
                                      nombreTarea: nuevoNombre)));
                            }
                          } else {
                            showAlertObjetivoVacio(context);
                          }
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

// --- Fondo animado igual que en creartareauno_view.dart ---
class _AnimatedBackground extends StatefulWidget {
  final List<_CircleData> circles;
  const _AnimatedBackground({required this.circles});

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
