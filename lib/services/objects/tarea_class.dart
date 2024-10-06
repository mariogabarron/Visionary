import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/objects/recordatorio.dart';

class Tarea {
  String name;
  int priority;
  int need_done;
  int times_done;
  List<DateTime> dates;
  Recordatorio? recordatorio;

  Tarea({
        required this.name,
        required this.priority,
        required this.need_done,
        this.dates = const [],
        this.times_done = 0,
        this.recordatorio
      });

  static Future<List<Tarea>> from_ref(DatabaseReference ref) async {
    throw UnimplementedError("No implementado");
  }



  bool isDone() {
    return need_done == times_done;
  }

  bool isPeriodic() {
    return need_done != 1;
  }

  void makeDone() {
    if(times_done < need_done) {
      times_done++;
      dates.add(DateTime.now());
    }
  }

  void makeUndone() {
    if(times_done > 0) {
      times_done--;
      dates.removeLast();
    }
  }


  

}
