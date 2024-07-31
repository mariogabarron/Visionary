import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialOverlay extends StatefulWidget {
  final Function onFinish;

  const TutorialOverlay({super.key, required this.onFinish});

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      _currentStep++;
      if (_currentStep >= 4) {
        widget.onFinish();
      }
    });
  }

  Widget _buildOverlayContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep(
          context: context,
          text: "Crea nuevos objetivos en la\n barra superior.",
        );
      case 1:
        return _buildStep(
          context: context,
          text: "Crea nuevas tareas para ir\n avanzando en tus objetivo.",
        );
      case 2:
        return _buildStep(
          context: context,
          text: "Entiende el motivo por el que\n deseas cumplirlo.",
        );
      case 3:
        return _buildStep(
          context: context,
          text: "Observa tu progreso",
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep({
    required BuildContext context,
    required String text,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _nextStep,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.arrow_circle_right_rounded,
                  color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.75),
        child: _buildOverlayContent(),
      ),
    );
  }
}
