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
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
        border: Border.all(
          color: const Color(0xFFFEFCEE),
          width: 2,
        ),
        // Fondo dinámico con gradiente
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey, // Color del progreso
            Colors.blueGrey, // Color del progreso
            Colors.grey[300]!, // Color del fondo restante
            Colors.grey[300]!, // Color del fondo restante
          ],
          stops: [
            0.0,
            porcentaje, // Hasta el porcentaje del progreso
            porcentaje, // Desde el porcentaje restante
            1.0,
          ],
        ),
      ),
      child: Center(
        child: Text(
          '${(porcentaje * 100).toStringAsFixed(1)}%', // Mostrar un decimal
          style: const TextStyle(
            color: Color.fromARGB(255, 38, 39, 44),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
