import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/utilities/progressbar.dart';

class ProgresoContainer extends StatefulWidget {
  final Future<List<Tarea>> tareasFuture;

  const ProgresoContainer({
    super.key,
    required this.tareasFuture,
  });

  @override
  State<ProgresoContainer> createState() => _ProgresoContainerState();
}

class _ProgresoContainerState extends State<ProgresoContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Duración de la animación
    );
    _loadProgreso();
  }

  Future<void> _loadProgreso() async {
    final tareas = await widget.tareasFuture;
    final totalTimesDone =
        tareas.fold(0, (sum, tarea) => sum + tarea.timesDone);
    final totalNeedDone = tareas.fold(0, (sum, tarea) => sum + tarea.needDone);
    final newProgress =
        totalNeedDone > 0 ? totalTimesDone / totalNeedDone : 0.0;

    // Configura la animación desde el progreso actual al nuevo progreso
    _progressAnimation = Tween<double>(
      begin: _currentProgress,
      end: newProgress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _currentProgress = _progressAnimation.value;
          });
        }
      });

    // Verifica si el widget sigue montado antes de iniciar la animación
    if (mounted) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Retraso de 2 segundos antes de mostrar el diálogo

        /*await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) showAlertProgreso(context, _currentProgress);*/ // para la beta no
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: ProgressBar(porcentaje: _currentProgress),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ProgresoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tareasFuture != oldWidget.tareasFuture) {
      _loadProgreso(); // Recargar el progreso si cambian las tareas
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
