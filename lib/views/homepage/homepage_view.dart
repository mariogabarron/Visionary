import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';
import 'package:visionary/views/homepage/homepage_widgets/frase_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/objetivos_row.dart';
import 'package:visionary/views/homepage/homepage_widgets/porque_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/progreso_container.dart';
import 'package:visionary/views/homepage/homepage_widgets/tareas_container.dart';
import 'package:visionary/views/tutorial_menu/tutorialoverlay_view.dart';

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
  bool _hasObjectives = true; // Variable para controlar si hay objetivos
  Future<bool>? _objectivesFuture; // Almacena el Future de los objetivos

  late AnimationController _animationController;
  late Animation<double> _animation;

  var selectedObjectiveName;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    _banner?.dispose();
    super.dispose();
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
    final objectives = (await VisionaryUser.fromLogin()).objectives;
    if (objectives.isNotEmpty) {
      selectedObjectiveName =
          objectives[0].$2.ref.path; // Selecciona el primer objetivo
      return true; // Hay objetivos
    } else {
      selectedObjectiveName = null;
      return false; // No hay objetivos
    }
  }

  void _onEmptyObjectives() {
    setState(() {
      _objectivesFuture = _checkObjectives(); // Regenera el Future
    });
  }

  dynamic onObjectiveSelected(String objectiveName) async {
    setState(() {
      selectedObjectiveName = objectiveName;
    });
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
            // Elimina el AnimatedBuilder de aquí
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(CupertinoIcons.gear_solid),
                color: const Color(0xFFFEFCEE),
                onPressed: () {
                  _showTutorial = false;
                  Navigator.of(context).pushReplacementNamed(ajustesCuenta);
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
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
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(CupertinoIcons.question_circle_fill),
                color: const Color(0xFFFEFCEE),
                onPressed: _tutorialMenuUno,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xFF6D97AC),
                      Color.fromARGB(255, 212, 176, 146),
                    ],
                    transform: GradientRotation(_animation.value),
                  ),
                ),
              );
            },
          ),
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
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: Divider(color: Color(0xFFFEFCEE)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              TareasContainer(
                                  objetivo: selectedObjectiveName ?? "A"),
                              const SizedBox(height: 30),
                              const PorqueLoHagoContainer(),
                              const SizedBox(height: 30),
                              progresoContainer(
                                  context: context, porcentaje: 0.4),
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
                                style: GoogleFonts.poppins(
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
                                Navigator.of(context)
                                    .pushReplacementNamed(crearObjetivoUno);
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
                                style: GoogleFonts.poppins(
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
          if (_showTutorial) TutorialOverlay(onFinish: _endTutorial),
        ],
      ),
    );
  }
}
