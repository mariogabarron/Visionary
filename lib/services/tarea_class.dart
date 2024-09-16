import 'package:visionary/services/periodicidad.dart';
import 'package:visionary/services/recordatorio.dart';

class Tarea {
  String name;
  int priority;
  int done;
  Periodicidad? periodicidad;
  Recordatorio? recordatorio;

  Tarea(
      {required this.name,
      this.periodicidad,
      required this.priority,
      required this.done,
      this.recordatorio});
}
