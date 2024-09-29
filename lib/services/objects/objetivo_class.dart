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

  bool isDone() {
    return terminado;
  }

  bool canBeDone() {
    if(listaTareas.isEmpty) {
      return false;
    }
    for(var t in listaTareas) {
      if(!t.isDone()) return false;
    }
    return true;
  }

  void makeDone() {
    if(canBeDone()) {
      terminado = true;
    }
  }



}

