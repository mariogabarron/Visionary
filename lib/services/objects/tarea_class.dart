import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/objects/recordatorio.dart';

class Tarea {
  String _name;
  int _priority;
  int _needDone;
  int _timesDone;
  List<DateTime> _dates;
  Recordatorio? _recordatorio;
  final String _dbRef;

  /// Claves de la base de datos referentes a la tarea.
  static final Set<String> _keys = {
    'name',
    'priority',
    'need_done',
    'times_done',
    'dates',
    'reminder'
  };

  Tarea(String objectiveRef,
      {required String name,
      required int priority,
      required int needDone,
      required Recordatorio? recordatorio})
      : _recordatorio = recordatorio,
        _needDone = needDone,
        _priority = priority,
        _name = name,
        _dates = const [],
        _timesDone = 0,
        _dbRef = FirebaseDatabase.instance
            .ref(objectiveRef)
            .child("tasks")
            .push()
            .path;

  /// Obtiene una tarea dada una referencia en base de datos. Si la referencia no apunta a una tarea válida, devuelve una excepción.
  static Future<Tarea> fromRef(DatabaseReference ref) async {
    String nombre = "";
    int priority = 0;
    int needDone = 0;
    int timesDone = 0;
    List<DateTime> dates = [];
    Recordatorio? reminder;

    if ((await ref.get()).exists) {
      List<Future<DataSnapshot>> futures = [];
      for (final entry in _keys) {
        futures.add(ref.child(entry).get());
      }

      await Future.wait(futures as Iterable<Future>);

      for (final entry in futures) {
        if (!(await entry).exists &&
            (await entry).key != 'dates' &&
            (await entry).key != 'reminder') {
          throw ArgumentError("The reference provided did not contain a task");
        } else {
          var e = await entry;
          if (e.key == 'name') nombre = e.value.toString();
          if (e.key == 'priority') priority = e.value as int;
          if (e.key == 'need_done') needDone = e.value as int;
          if (e.key == 'times_done') timesDone = e.value as int;
          if (e.key == 'dates') {
            dates = e.children
                .map((x) => DateTime.parse(x.value.toString()))
                .toList();
          }
          if (e.key == 'reminder') reminder = await Recordatorio.fromRef(e.ref);
        }
      }
      var result = Tarea(ref.parent!.parent!.path,
          name: nombre,
          priority: priority,
          needDone: needDone,
          recordatorio: reminder);
      result._dates = dates;
      result._recordatorio = reminder;
      result._timesDone = timesDone;
      return result;
    }
    throw ArgumentError("The reference provided did not contain a task");
  }

  /// Obtiene la lista de tareas de un objeto dada su referencia en base de datos. Devuelve una excepción si no era un objetivo.
  static Future<List<Tarea>> getList(DatabaseReference objRef) async {
    List<Future<Tarea>> futures = [];
    List<Tarea> result = [];
    var ref = await objRef.get();
    for (var entry in ref.children) {
      futures.add(fromRef(entry.ref));
    }
    await Future.wait(futures as Iterable<Future>);

    for (var f in futures) {
      result.add(await f);
    }
    return result;
  }

  String get name => _name;

  int get priority => _priority;

  int get needDone => _needDone;

  int get timesDone => _timesDone;

  Recordatorio? get recordatorio => _recordatorio;

  String get dbRef => _dbRef;

  /// Determina si la tarea está terminada
  bool isDone() {
    return _needDone == _timesDone;
  }

  /// Determina si la tarea es periódica.
  bool isPeriodic() {
    return _needDone != 1;
  }

  /// Completa la tarea una vez.
  void makeDone() {
    if (_timesDone < _needDone) {
      _timesDone++;
      _dates.add(DateTime.now());
    }
    update();
  }

  /// Descompleta la tarea una vez.
  void makeUndone() {
    if (_timesDone > 0) {
      _timesDone--;
      _dates.removeLast();
    }
    update();
  }

  /// Edita la tarea. ¡OJO! Si las vecesNecesarias son menores a las veces que se ha completado la tarea, ese campo no se editará.
  void editarTarea(String nombre, int prioridad, int vecesNecesarias,
      Recordatorio? recordatorio) {
    _name = nombre;
    _priority = prioridad;
    _recordatorio = recordatorio;

    if (vecesNecesarias >= _timesDone) _needDone = vecesNecesarias;
    update();
  }

  /// Loguea en la consola los atributos de la tarea.
  void print() {
    log("Nombre: $_name, Prioridad: $_priority, Veces hecha: $_timesDone, Veces necesarias: $_needDone");
    if (_recordatorio == null) {
      log("Sin recordatorio asignado");
    } else {
      _recordatorio!.print();
    }
  }

  /// Actualiza la tarea en base de datos.
  void update() async {
    if (_recordatorio != null) {
      await FirebaseDatabase.instance.ref(_dbRef).update({
        'name': _name,
        'priority': _priority,
        'need_done': _needDone,
        'times_done': _timesDone,
        'dates': _dates,
        'reminder': _recordatorio!.toDbScheme()
      });
    } else {
      await FirebaseDatabase.instance.ref(_dbRef).update({
        'name': _name,
        'priority': _priority,
        'need_done': _needDone,
        'times_done': _timesDone,
        'dates': _dates,
      });
    }
  }

  /// Borra la tarea de la base de datos. NO LA BORRA DE LA LISTA DE OBJETIVOS.
  Future<void> deleteTask() async {
    await FirebaseDatabase.instance.ref(_dbRef).remove();
  }
}
