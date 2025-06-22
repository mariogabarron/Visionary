import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/auth/auth_user.dart';
import 'package:visionary/utilities/showdialogs/borrarcuenta_showdialog.dart';

class AjustesCuenta extends StatefulWidget {
  const AjustesCuenta({super.key});
  @override
  State<AjustesCuenta> createState() => _AjustesCuentaState();
}

class _AjustesCuentaState extends State<AjustesCuenta> {
  void _cerrarSesion() {
    logOut();
    Navigator.of(context).pushReplacementNamed(registerView);
  }

  void _politicaPrivacidad() async {
    final Uri url = Uri.parse(
        'https://visionarytheapp.wixsite.com/visionary/copy-of-new-page');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('No se pudo abrir la política de privacidad.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al abrir la política de privacidad.')),
        );
      }
    }
  }

  void _terminosYCondiciones() async {
    final Uri url = Uri.parse(
        'https://visionarytheapp.wixsite.com/visionary/terms-conditions');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('No se pudo abrir la política de privacidad.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al abrir la política de privacidad.')),
        );
      }
    }
  }

  void _valorarApp() {}
  void _borrarCuenta() {
    showAlertBorrarCuenta(context);
  }

  //void ayudaConfiguracion() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // Cambia pushReplacementNamed por pushNamed para que funcione como pila
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Stack(
          children: [
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(CupertinoIcons.arrow_left_circle_fill),
                color: const Color(0xFFFEFCEE),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 4.0), // Baja un poco el título
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
          ],
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
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Text(
                    "Configuración",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFEFCEE),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 40),*/
                /*_AjustesButton(
                  text: 'Ayuda',
                  onTap: ayudaConfiguracion,
                ),*/
                const SizedBox(height: 40),
                _AjustesButton(
                  text: 'Política de privacidad',
                  onTap: _politicaPrivacidad,
                ),
                const SizedBox(height: 40),
                _AjustesButton(
                  text: 'Valorar aplicación',
                  onTap: _valorarApp,
                ),
                const SizedBox(height: 40),
                _AjustesButton(
                  text: 'Términos y condiciones',
                  onTap: _terminosYCondiciones,
                ),
                const SizedBox(height: 40),
                _AjustesButton(
                  text: 'Cerrar sesión',
                  onTap: _cerrarSesion,
                ),
                const SizedBox(height: 40),
                _AjustesButton(
                  text: 'Borrar cuenta',
                  onTap: _borrarCuenta,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Botón con estilo "liquid" y borde, igual que los containers de la homepage
class _AjustesButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _AjustesButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(66, 254, 252, 238),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: const Color(0xFFFEFCEE).withOpacity(0.18),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6D97AC).withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          text,
          style: GoogleFonts.kantumruyPro(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}

// Añade esto si _AnimatedBackground y _CircleData no están exportados desde homepage_view.dart
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
