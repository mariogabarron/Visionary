import 'dart:async';
import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';
import 'package:visionary/utilities/showdialogs/connectionlost.dart';
import 'package:visionary/views/homepage/homepage_widgets/frase_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/objetivos_row.dart';
import 'package:visionary/views/homepage/homepage_widgets/porque_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/progreso_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/tareas_container.dart';
import 'package:visionary/views/tutorial_menu/tutorialoverlay_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView>
    with SingleTickerProviderStateMixin {
  bool _showTutorial = false;
  BannerAd? _banner;
  bool _isAdLoaded = false;
  Future<bool>? _objectivesFuture; // Almacena el Future de los objetivos

  late AnimationController _animationController;
  late Animation<double> _animation;

  String? selectedObjectiveName;
  int? selectedObjectiveIndex;

  final ValueNotifier<bool> _isConnectedNotifier = ValueNotifier(true);
  Timer? _connectionTimer; // Temporizador para verificar la conexión

  @override
  void initState() {
    super.initState();

    // Inicializar AnimationController y Animation primero
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // Añade esta línea para evitar el warning:
    // ignore: unused_field
    _animation;

    // Luego, inicializar el Future de objetivos
    _objectivesFuture = _checkObjectives();

    // Inicializar los anuncios
    String id = Platform.isAndroid
        ? "ca-app-pub-9277052423554636/5898360447"
        : 'ca-app-pub-9277052423554636/8823906684';

    _banner = BannerAd(
      adUnitId: id,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          d.log("Error al cargar anuncio: $error");
        },
      ),
    )..load();

    _startConnectionCheck();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _banner?.dispose();
    _connectionTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!_isConnectedNotifier.value) {
          _isConnectedNotifier.value = true; // Actualiza solo si cambia
        }
      }
    } on SocketException catch (_) {
      if (_isConnectedNotifier.value) {
        _isConnectedNotifier.value = false; // Actualiza solo si cambia
      }
    }
  }

  void _startConnectionCheck() {
    _connectionTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkConnection();
    });
  }

  void _tutorialMenuUno() {
    setState(() {
      _showTutorial = true;
    });
  }

  void _endTutorial() {
    setState(() {
      _showTutorial = false;
    });
  }

  Future<bool> _checkObjectives() async {
    final prefs = await SharedPreferences.getInstance();
    final storedIndex = prefs.getInt('selectedObjetivoIndex');
    final user = await VisionaryUser.fromLogin();
    final objectives = user.objectives;

    if (objectives.isNotEmpty) {
      // Si hay un índice almacenado, úsalo; de lo contrario, selecciona el primero
      if (storedIndex != null && storedIndex < objectives.length) {
        selectedObjectiveIndex = storedIndex;
        selectedObjectiveName = objectives[storedIndex].$2.ref.path;
      } else {
        selectedObjectiveIndex ??= 0; // Solo asigna si es null
        selectedObjectiveName ??= objectives[0].$2.ref.path;
      }
      return true; // Hay objetivos
    } else {
      selectedObjectiveIndex = null;
      selectedObjectiveName = null;
      return false; // No hay objetivos
    }
  }

  void _onEmptyObjectives() {
    setState(() {
      _objectivesFuture = _checkObjectives(); // Regenera el Future
    });
  }

  dynamic onObjectiveSelected(String objectiveName, int index) {
    setState(() {
      selectedObjectiveName = objectiveName;
      selectedObjectiveIndex = index;
    });
  }

  Future<List<Tarea>> getListaTareas() async {
    if (selectedObjectiveName == null) {
      return []; // Si no hay objetivo seleccionado, devuelve una lista vacía
    }
    final ref = FirebaseDatabase.instance.ref(selectedObjectiveName!);
    final objetivo = await Objetivo.fromRef(ref);
    return objetivo.listaTareas;
  }

  void actualizarProgreso() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFFFEFCEE),
        ),
        title: Stack(
          children: [
            Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.gear_solid),
                    color: Color(0xFFFEFCEE),
                    onPressed: () {
                      _showTutorial = false;
                      // CAMBIA pushReplacementNamed POR pushNamed PARA QUE FUNCIONE COMO PILA
                      Navigator.of(context).pushNamed(ajustesCuenta);
                    },
                  ),
                )),
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
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.8,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.question_circle_fill),
                  color: const Color(0xFFFEFCEE),
                  onPressed: _tutorialMenuUno,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Fondo base oscuro para que los círculos no se vean sobre blanco
          Container(
            color: const Color.fromARGB(255, 0, 0, 0), // Fondo oscuro
          ),
          _AnimatedBackground(),
          SafeArea(
            bottom: false,
            child: FutureBuilder<bool>(
              future: _objectivesFuture, // Usa el Future almacenado
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFFEFCEE)),
                      strokeWidth: 3.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Maneja errores aquí
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.data == true) {
                  // Si hay objetivos, muestra el contenido normal
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ObjetivosRow(
                          onObjectiveSelected: onObjectiveSelected,
                          onObjectiveDeleted: _onEmptyObjectives,
                          selectedObjectiveIndex: selectedObjectiveIndex,
                        ),
                        const SizedBox(height: 10),
                        /*const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: Divider(color: Color(0xFFFEFCEE)),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              TareasContainer(
                                  objetivo: selectedObjectiveName ?? "A",
                                  onTaskUpdated: actualizarProgreso),
                              const SizedBox(height: 30),
                              PorqueLoHagoContainer(
                                objetivo: selectedObjectiveName ?? "A",
                                onTaskUpdated: actualizarProgreso,
                                // Pasa el notificador
                              ),
                              const SizedBox(height: 30),
                              ProgresoContainer(
                                tareasFuture: getListaTareas(),
                              ),
                              const SizedBox(height: 30),
                              const FraseContainer(),
                              const SizedBox(height: 30),
                              if (_isAdLoaded)
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: _banner!.size.width.toDouble(),
                                  height: _banner!.size.height.toDouble(),
                                  child: AdWidget(ad: _banner!),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Si no hay objetivos, muestra la vista vacía
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Center(
                              child: Text(
                                'Añade tu primer objetivo para empezar a cumplirlo.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.kantumruyPro(
                                  color: const Color(0xFFFEFCEE),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextButton(
                              onPressed: () {
                                // Usa pushNamed en vez de pushReplacementNamed para que funcione bien el back
                                Navigator.of(context)
                                    .pushNamed(crearObjetivoUno);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFFFEFCEE).withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Añadir objetivo',
                                style: GoogleFonts.kantumruyPro(
                                  color: const Color(0xFFFEFCEE),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isConnectedNotifier,
            builder: (context, isConnected, child) {
              if (!isConnected) {
                return showAlertConnectionLost(context);
              }
              return const SizedBox.shrink();
            },
          ),
          if (_showTutorial) TutorialOverlay(onFinish: _endTutorial),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    // Usa los colores originales del gradiente de la app
    _circles = [
      _CircleData(
        color: const Color(0xFF6D97AC).withOpacity(0.32),
        radius: 220,
        dx: -0.5,
        dy: -0.6,
        vx: 0.008,
        vy: 0.006,
      ),
      _CircleData(
        color: const Color.fromARGB(255, 212, 176, 146).withOpacity(0.22),
        radius: 180,
        dx: 0.6,
        dy: -0.4,
        vx: -0.006,
        vy: 0.007,
      ),
      _CircleData(
        color: const Color(0xFF6D97AC).withOpacity(0.18),
        radius: 150,
        dx: 0.8,
        dy: 0.7,
        vx: -0.004,
        vy: -0.006,
      ),
      _CircleData(
        color: const Color.fromARGB(255, 212, 176, 146).withOpacity(0.13),
        radius: 120,
        dx: -0.9,
        dy: 0.3,
        vx: 0.005,
        vy: 0.004,
      ),
      _CircleData(
        color: const Color(0xFF6D97AC).withOpacity(0.13),
        radius: 140,
        dx: 0.0,
        dy: 0.95,
        vx: 0.004,
        vy: -0.004,
      ),
    ];
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
            // Animación automática de los círculos
            for (final c in _circles) {
              c.dx += c.vx * 0.6;
              c.dy += c.vy * 0.6;
              // Rebote en los bordes
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
