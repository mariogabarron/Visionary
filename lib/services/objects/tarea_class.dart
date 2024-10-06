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
        _dbRef = userRoute()!.child(objectiveRef).child("tasks").push().path;

  static Future<List<Tarea>> from_ref(DatabaseReference ref) async {
    throw UnimplementedError("No implementado");
  }



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


  

}
