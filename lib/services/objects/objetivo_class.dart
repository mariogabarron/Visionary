import 'package:visionary/services/objects/tarea_class.dart';

class Objetivo {
  String nombre;
  String porquelohago;
  List<Tarea> listaTareas;
  DateTime fecha_creado;
  DateTime? fecha_terminado;
  bool terminado;

  Objetivo({
    required this.nombre,
    required this.porquelohago}) :
    listaTareas = const [],
    fecha_creado = DateTime.now(),
    fecha_terminado = null,
    terminado = false;

}

