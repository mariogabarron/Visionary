import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class TutorialInicio extends StatefulWidget {
  const TutorialInicio({super.key});
  @override
  State<TutorialInicio> createState() => _TutorialInicioState();
}

class _TutorialInicioState extends State<TutorialInicio> {
  final List<Map<String, String>> tutorials = [
    {
      'image': 'assets/images/tutorialuno.png',
      'title': 'Visionary',
      'text': 'es la herramienta que te ayudará a cumplir tus objetivos',
    },
    {
      'image': 'assets/images/tutorialdos.png',
      'title': 'Organizar tus objetivos creando tareas',
      'text': 'te ayudará a mejorar cada día',
    },
    {
      'image': 'assets/images/tutorialcuatro.png',
      'title': 'Lleva el control de tus objetivos',
      'text': 'con la barra de progreso.',
    },
  ];

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    inicialization();
  }

  void inicialization() async {
    await Future.delayed(const Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  void nextPage() {
    if (currentPage < tutorials.length - 1) {
      setState(() {
        currentPage++;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(registerView, (route) => false);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Padding(
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
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 0, 0),
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
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tutorials.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(tutorials[index]['image']!),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: const Color(0xFFFEFCEE),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: tutorials[index]['title']!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "\n${tutorials[index]['text']!}",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentPage == 0
                        ? [
                            RotatedBox(
                              quarterTurns: 3,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_downward_sharp,
                                  color: Color(0xFFFEFCEE),
                                ),
                                onPressed: nextPage,
                              ),
                            ),
                          ]
                        : [
                            RotatedBox(
                              quarterTurns: 3,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_upward_sharp,
                                  color: Color(0xFFFEFCEE),
                                ),
                                onPressed: previousPage,
                              ),
                            ),
                            const SizedBox(width: 20),
                            RotatedBox(
                              quarterTurns: 3,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_downward_sharp,
                                  color: Color(0xFFFEFCEE),
                                ),
                                onPressed: nextPage,
                              ),
                            ),
                          ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- Fondo animado igual que en el resto ---
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
