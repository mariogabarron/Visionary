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
  String _dbRef;

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

  Tarea.desdeRef(
    String dbRef, {
    required String name,
    required int priority,
    required int needDone,
    required int timesDone,
    required List<DateTime> dates,
    Recordatorio? recordatorio,
  })  : _dbRef = dbRef,
        _name = name,
        _priority = priority,
        _needDone = needDone,
        _timesDone = timesDone,
        _dates = const [],
        _recordatorio = recordatorio;

  /// Obtiene una tarea dada una referencia en base de datos. Si la referencia no apunta a una tarea válida, devuelve una excepción.
  static Future<Tarea> fromRef(DatabaseReference ref) async {
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      throw ArgumentError("La referencia proporcionada no contiene una tarea.");
    }

    // Se extraen los datos de la tarea del snapshot.
    String nombre = snapshot.child('name').value.toString();
    int priority = snapshot.child('priority').value as int;
    int needDone = snapshot.child('need_done').value as int;
    int timesDone = snapshot.child('times_done').value as int;

    // Obtener la lista de fechas.
    List<DateTime> dates = [];
    final datesSnapshot = snapshot.child('dates');
    if (datesSnapshot.exists) {
      dates = datesSnapshot.children
          .map((child) => DateTime.parse(child.value.toString()))
          .toList();
    }

    // Obtener el recordatorio, si existe.
    Recordatorio? reminder;
    final reminderSnapshot = snapshot.child('reminder');
    if (reminderSnapshot.exists) {
      reminder = await Recordatorio.fromRef(reminderSnapshot.ref);
    }

    // Usar el constructor Tarea.desdeRef para reconstruir la tarea, asignando la referencia existente.
    return Tarea.desdeRef(
      ref.path,
      name: nombre,
      priority: priority,
      needDone: needDone,
      timesDone: timesDone,
      dates: dates,
      recordatorio: reminder,
    );
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
      // _dates.add(DateTime.now());
    }
    update();
  }

  /// Descompleta la tarea una vez.
  void makeUndone() {
    if (_timesDone > 0) {
      _timesDone--;
      //_dates.removeLast();
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
