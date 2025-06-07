import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double porcentaje;
  const ProgressBar({super.key, required this.porcentaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 30,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 23, 23), // Fondo gris oscuro
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.transparent,
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
                color: const Color(0xFFFEFCEE), // Color del progreso
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
          // Texto centrado
          Center(
            child: Text(
              '${(porcentaje * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                color: Color.fromARGB(255, 118, 118, 118),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
