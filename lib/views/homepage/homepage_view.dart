import 'dart:developer' as d;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visionary/routes/routes.dart';
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
    _banner = BannerAd(
      adUnitId: 'ca-app-pub-9277052423554636/8823906684',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  objetivosRow(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                    child: Divider(color: Color(0xFFFEFCEE)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const TareasContainer(),
                        const SizedBox(height: 30),
                        const PorqueLoHagoContainer(),
                        const SizedBox(height: 30),
                        progresoContainer(context: context, porcentaje: 0.4),
                        const SizedBox(height: 50),
                        const FraseContainer(),
                        const SizedBox(height: 30),
                        if (_isAdLoaded)
                          Container(
                            alignment: Alignment.center,
                            width: _banner!.size.width.toDouble(),
                            height: _banner!.size.height.toDouble(),
                            child: AdWidget(ad: _banner!),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showTutorial) TutorialOverlay(onFinish: _endTutorial),
        ],
      ),
    );
  }
}
