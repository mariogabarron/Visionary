import 'package:flutter/material.dart';
import 'dart:ui';

class ProgressBar extends StatelessWidget {
  final double porcentaje;
  const ProgressBar({super.key, required this.porcentaje});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
        child: Container(
          width: 320,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              // Barra de progreso (relleno)
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: porcentaje.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFCEE),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              // Texto centrado
              Center(
                child: Text(
                  '${(porcentaje * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 163, 163, 163),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
