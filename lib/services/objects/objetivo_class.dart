import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/db/db_user_management.dart';
import 'package:visionary/services/objects/recordatorio.dart';
import 'package:visionary/services/objects/tarea_class.dart';

class Objetivo {
  String _nombre;
  String _porquelohago;
  String _dbref;
  List<Tarea> _listaTareas;
  DateTime _fechaCreado;
  DateTime? _fechaTerminado;
  bool _terminado;

  /// Claves de los campos de la base de datos.
  static final Set<String> _keys = {
    'name',
    'motive',
    'created_at',
    'finished',
    'finished_at',
    'tasks'
  };

  Objetivo({required String nombre, required String porquelohago})
      : _nombre = nombre,
        _porquelohago = porquelohago,
        _listaTareas = [],
        _fechaCreado = DateTime.now(),
        _fechaTerminado = null,
        _dbref = userRoute()!.child("objectives").push().path,
        _terminado = false;

  /// Obtiene un objetivo desde la referencia en la base de datos
  static Future<Objetivo> fromRef(DatabaseReference ref) async {
    String nombre = "";
    String porquelohago = "";
    DateTime fechaCreado = DateTime.now();
    DateTime? fechaTerminado;
    List<Tarea> listaTareas = [];
    bool terminado = false;

    if ((await ref.get()).exists) {
      List<Future<DataSnapshot>> futures = [];
      for (final entry in _keys) {
        futures.add(ref.child(entry).get());
      }
      await Future.wait(futures as Iterable<Future>);
      for (final entry in futures) {
        if (!(await entry).exists && (await entry).key != 'tasks') {
          throw ArgumentError(
              "The reference provided did not contain an objective.");
        } else {
          var e = await entry;
          if (e.key == 'name') nombre = e.value.toString();
          if (e.key == 'motive') porquelohago = e.value.toString();
          if (e.key == 'created_at') fechaCreado = DateTime.parse(e.value.toString());
          if (e.key == 'finished_at') fechaTerminado = e.value.toString() == "null" ? null : DateTime.parse(e.value.toString());
          if (e.key == 'tasks') listaTareas = await Tarea.getList(e.ref);
          if (e.key == 'finished') terminado = e.value.toString().toLowerCase() == "true";
        }
      }
      var result = Objetivo(nombre: nombre, porquelohago: porquelohago);
      result._fechaCreado = fechaCreado;
      result._fechaTerminado = fechaTerminado;
      result._listaTareas = listaTareas;
      result._dbref = ref.path;
      result._terminado = terminado;
      return result;
    }
    throw ArgumentError("The reference provided did not contain an objective.");
  }

  /// Obtiene la lista de objetivos del usuario.
  static Future<List<Objetivo>> getList() async {
    List<Future<Objetivo>> futures = [];
    List<Objetivo> result = [];
    var ref = await userRoute()!.child("objectives").get();
    for(var entry in ref.children) {
      futures.add(fromRef(entry.ref));
    }
    await Future.wait(futures as Iterable<Future>);
    for(var f in futures) {
      result.add(await f);
    }
    return result;
  }

  String get name => _nombre;

  String get motive => _porquelohago;

  bool get isDone => _terminado;

  DateTime get createdAt => _fechaCreado;

  bool get finished => _fechaTerminado != null;

  DateTime? get finishedAt => _fechaTerminado;



  /// Actuliza el objetivo en la base de datos.
  void update() async {
    await FirebaseDatabase.instance.ref(_dbref).update({
      'name': _nombre,
      'motive': _porquelohago,
      'created_at': _fechaCreado.toUtc().toIso8601String(),
      'finished_at': _fechaTerminado == null
          ? "null"
          : _fechaTerminado!.toUtc().toIso8601String(),
      'finished': _terminado
    });
    for(var task in _listaTareas) {
      task.update();
    }
  }

  /// Edita el nombre y el porqué del objetivo.
  void edit(String newName, String newMotive) {
    _nombre = newName;
    _porquelohago = newMotive;
    update();
  }

  /// Determina si el objetivo puede marcarse como completado (solo si todas las tareas han sido completadas)
  bool canBeDone() {
    if (_listaTareas.isEmpty) {
      return false;
    }
    for (var t in _listaTareas) {
      if (!t.isDone()) return false;
    }
    return true;
  }

  /// Da por terminado el objetivo, si es posible.
  void makeDone() {
    if (canBeDone()) {
      _terminado = true;
      _fechaTerminado = DateTime.now();
      update();
    }
  }

  /// Añade una nueva tarea al objetivo, y actualiza la base de datos.
  void addTask(String name, int priority, int needDone, Recordatorio? reminder) {
    _listaTareas.add(Tarea(_dbref, name: name, priority: priority, needDone: needDone, recordatorio: reminder));
    update();
  }

  /// Imprime los campos del objetivo
  void print() {
    log("Objetivo: $_nombre, Motivo: $_porquelohago, Creado: $_fechaCreado, Terminado: $_terminado. Tareas a continuación.");
    if (_listaTareas.isEmpty) {
      log("Lista de tareas vacía");
    }
    else {
      for(var tarea in _listaTareas) {
        tarea.print();
      }
    }


  }
}
