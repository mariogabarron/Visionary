import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FraseContainer extends StatefulWidget {
  const FraseContainer({super.key});

  @override
  State<StatefulWidget> createState() => _FraseContainerState();
}

class _FraseContainerState extends State<FraseContainer>
    with SingleTickerProviderStateMixin {
  final _random = Random();
  final List<String> _listaFrases = [
    "\"Si fallas al planear, planeas fallar\"",
    "\"La mejor manera de predecir el futuro es crearlo\"",
    "\"Un objetivo sin un plan es solo un deseo\"",
    "\"Si no sabes a dónde vas, cualquier camino te llevará allí\"",
    "\"El futuro pertenece a quienes lo planifican\"",
    "\"Un buen plan es la mitad del trabajo\"",
    "\"El miedo al fracaso es peor que el fracaso en sí\"",
    "\"No hay mejor momento que el presente\"",
    "\"Lo que te distingue no es lo que haces, sino cómo lo haces\"",
    "\"Si quieres algo que nunca has tenido, tienes que hacer algo que nunca has hecho\"",
    "\"La actitud, no la aptitud, determina la altitud\"",
    "\"No te limites a soñar, trabaja para lograrlo\"",
    "\"El éxito es la suma de pequeños esfuerzos repetidos día tras día\"",
  ];

  int _numeroAleatorio = 0;
  Timer? _timer;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _startTimer();
  }

  void _startTimer() {
    const duration = Duration(seconds: 15);
    _timer = Timer.periodic(duration, (timer) async {
      if (_isFirstTime) {
        _isFirstTime = false; // Desmarcar para futuras ejecuciones
        return;
      }
      setState(() {
        _numeroAleatorio = _random.nextInt(13);
        _controller.forward(from: 0.0); // Reset and start animation on change
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Text(_listaFrases[_numeroAleatorio],
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
      ),
    );
  }
}
