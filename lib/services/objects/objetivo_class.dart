import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/db/db_user_management.dart';
import 'package:visionary/services/objects/tarea_class.dart';

class Objetivo {
  String _nombre;
  String _porquelohago;
  String _dbref;
  List<Tarea> _listaTareas;
  DateTime _fecha_creado;
  DateTime? _fecha_terminado;
  bool _terminado;

  static final Set<String> _keys = {
    'name',
    'motive',
    'created_at',
    'finished_at',
    'tasks'
  };



  Objetivo({
    required String nombre,
    required String porquelohago}) :  _nombre = nombre, _porquelohago = porquelohago,
    _listaTareas = const [],
    _fecha_creado = DateTime.now(),
    _fecha_terminado = null,
    _dbref = userRoute()!.push().path,
    _terminado = false;

  static Future<Objetivo> from_ref(DatabaseReference ref) async {
    String nombre = "";
    String porquelohago = "";
    DateTime fecha_creado = DateTime.now();
    DateTime? fecha_terminado;
    List<Tarea> lista_tareas = [];

    if ((await ref.get()).exists) {
      List<Future<DataSnapshot>> futures = [];
      for (final entry in _keys) {
        futures.add(ref.child(entry).get());
      }
      await Future.wait(futures as Iterable<Future>);
      for (final entry in futures) {
        if (!(await entry).exists && (await entry).key != 'tasks') {
          throw ArgumentError("The reference provided did not contain an objective.");
        }
        else {
          var e = await entry;
          if (e.key == 'name') nombre = e.value.toString();
          if (e.key == 'motive') porquelohago = e.value.toString();
          if (e.key == 'created_at') fecha_creado = DateTime.parse(e.value.toString());
          if (e.key == 'finished_at') fecha_terminado = e.value.toString() == "null" ? null : DateTime.parse(e.value.toString());
          if (e.key == 'tasks') lista_tareas = await Tarea.from_ref(e.ref);
        }
      }
      var result = Objetivo(nombre: nombre, porquelohago: porquelohago);
      result._fecha_creado = fecha_creado;
      result._fecha_terminado = fecha_terminado;
      result._listaTareas = lista_tareas;
      result._dbref = ref.path;
      return result;

    }
    throw ArgumentError("The reference provided did not contain an objective.");
  }

  String get name => _nombre;
  String get motive => _porquelohago;
  bool get isDone => _terminado;
  DateTime get createdAt => _fecha_creado;
  bool get finished => _fecha_terminado != null;
  DateTime? get finishedAt => _fecha_terminado;

  void update() {
    FirebaseDatabase.instance.ref(_dbref).update({
      'name': _nombre,
      'motive': _porquelohago,
      'created_at': _fecha_creado.toUtc().toIso8601String(),
      'finished_at': _fecha_terminado == null ? "null" : _fecha_terminado!.toUtc().toIso8601String(),
    });
  }

  void edit(String new_name, String new_motive) {
    _nombre = new_name;
    _porquelohago = new_motive;
    update();
  }

  bool canBeDone() {
    if(_listaTareas.isEmpty) {
      return false;
    }
    for(var t in _listaTareas) {
      if(!t.isDone()) return false;
    }
    return true;
  }

  void makeDone() {
    if(canBeDone()) {
      _terminado = true;
      _fecha_terminado = DateTime.now();
      update();
    }
  }




}

