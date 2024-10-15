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

  @override
  void initState() {
    super.initState();
    String id = "";
    if (Platform.isAndroid) {
      id = "ca-app-pub-9277052423554636/5898360447";
    } else if (Platform.isIOS) {
      id = 'ca-app-pub-9277052423554636/8823906684';
    }
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
          d.log("QUE $error");
        },
      ),
    )..load();
  }

  @override
  void dispose() {
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
    return objectives.isNotEmpty;
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6D97AC), Color.fromARGB(255, 212, 176, 146)],
                transform: GradientRotation(88 * pi / 180),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: FutureBuilder<bool>(
              future: _checkObjectives(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Mientras se espera la respuesta, muestra un cargador
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
                        const ObjetivosRow(),
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
                              const TareasContainer(),
                              const SizedBox(height: 30),
                              const PorqueLoHagoContainer(),
                              const SizedBox(height: 30),
                              progresoContainer(
                                  context: context, porcentaje: 0.4),
                              const SizedBox(height: 20),
                              const FraseContainer(),
                              const SizedBox(height: 20),
                              if (_isAdLoaded)
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: _banner!.size.width.toDouble(),
                                  height: _banner!.size.height.toDouble(),
                                  child: AdWidget(ad: _banner!),
                                )
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'Añade tu primer objetivo para empezar a cumplirlo.',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFFFEFCEE),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 0.0),
                            child: Divider(color: Colors.transparent),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
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
                                child: Text('Añadir objetivo',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFFFEFCEE),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
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
