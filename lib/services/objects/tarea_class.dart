import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/db/db_user_management.dart';
import 'package:visionary/services/objects/recordatorio.dart';

class Tarea {
  String _name;
  int _priority;
  int _needDone;
  int _timesDone;
  List<DateTime> _dates;
  Recordatorio? _recordatorio;
  String _dbRef;

  static final Set<String> _keys = {
    'name',
    'priority',
    'need_done',
    'times_done',
    'dates',
    'reminder'
  };

  Tarea(String objectiveRef, {
        required String name,
        required int priority,
        required int need_done,
        required Recordatorio? recordatorio}) : _recordatorio = recordatorio, _needDone = need_done, _priority = priority, _name = name,
        _dates = const [],
        _timesDone = 0,
        _dbRef = FirebaseDatabase.instance.ref(objectiveRef).child("tasks").push().path;

  static Future<Tarea> fromRef(DatabaseReference ref) async {
    String nombre = "";
    int priority = 0;
    int need_done = 0;
    int times_done = 0;
    List<DateTime> dates = [];
    Recordatorio? reminder = null;

    if((await ref.get()).exists) {
      List<Future<DataSnapshot>> futures = [];
      for(final entry in _keys) {
        futures.add(ref.child(entry).get());
      }

      await Future.wait(futures as Iterable<Future>);

      for (final entry in futures) {
        if(!(await entry).exists && (await entry).key != 'dates' && (await entry).key != 'reminder') {
          throw ArgumentError("The reference provided did not contain a task");
        }
        else {
          var e = await entry;
          if(e.key == 'name') nombre = e.value.toString();
          if(e.key == 'priority') priority = e.value as int;
          if(e.key == 'need_done') need_done = e.value as int;
          if(e.key == 'times_done') times_done = e.value as int;
          if(e.key == 'dates') dates = e.children.map( (x) => DateTime.parse(x.value.toString())).toList();
          if(e.key == 'reminder') reminder = await Recordatorio.fromRef(e.ref);
        }
      }
      var result = Tarea(ref.parent!.parent!.path ,name: nombre, priority: priority, need_done: need_done, recordatorio: reminder);
      result._dates = dates;
      result._recordatorio = reminder;
      result._timesDone = times_done;
      return result;
    }
    throw ArgumentError("The reference provided did not contain a task");

  }

  static Future<List<Tarea>> getList(DatabaseReference obj_ref) async {
    List<Future<Tarea>> futures = [];
    List<Tarea> result = [];
    var ref = await obj_ref.get();
    for(var entry in ref.children) {
      futures.add(fromRef(entry.ref));
    }
    await Future.wait(futures as Iterable<Future>);

    for(var f in futures) {
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



  bool isDone() {
    return _needDone == _timesDone;
  }

  bool isPeriodic() {
    return _needDone != 1;
  }

  void makeDone() {
    if(_timesDone < _needDone) {
      _timesDone++;
      _dates.add(DateTime.now());
    }
  }

  void makeUndone() {
    if(_timesDone > 0) {
      _timesDone--;
      _dates.removeLast();
    }
  }

  void print() {
    log("Nombre: $_name, Prioridad: $_priority, Veces hecha: $_timesDone, Veces necesarias: $_needDone");
  }

  void update() {
    FirebaseDatabase.instance.ref(_dbRef).update({
      'name': _name,
      'priority': _priority,
      'need_done': _needDone,
      'times_done': _timesDone,
    });
  }

}
