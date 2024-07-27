import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double porcentaje;
  const ProgressBar({super.key, required this.porcentaje});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 300 * porcentaje,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Center(
            child: Text(
              '${(porcentaje * 100).toInt()}%',
              style: const TextStyle(
                color: Color.fromARGB(102, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
