import 'package:visionary/services/periodicidad.dart';
import 'package:visionary/services/recordatorio.dart';

class Tarea {
  final String name;
  final int priority;
  final bool done;
  Periodicidad? periodicidad;
  Recordatorio? recordatorio;
  Tarea(
      {required this.name,
      this.periodicidad,
      required this.priority,
      required this.done,
      this.recordatorio});
}
