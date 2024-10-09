import 'package:firebase_database/firebase_database.dart';

enum TipoRecordatorio { mensual, semanal }

class Recordatorio {
  TipoRecordatorio tipoRecordatorio;
  String codigo;
  (int, int) hora;
  Recordatorio({required this.tipoRecordatorio, required this.hora, required this.codigo});

  static final Set<String> _keys = {
    'type',
    'code',
    'hora',
  };

  static TipoRecordatorio stringToReminder(String r) {
    if (r == "M") return TipoRecordatorio.mensual;
    else if (r == "S") return TipoRecordatorio.semanal;

    throw ArgumentError("The provided string was not a valid reminder.");
  }

  static Future<Recordatorio> fromRef(DatabaseReference ref) async {
    TipoRecordatorio reminder = TipoRecordatorio.semanal;
    String code = "";
    (int, int) hora = (0, 0);
    for(var entry in (await ref.get()).children) {
      if(entry.key.toString() == "type") reminder = stringToReminder(entry.value.toString());
      if(entry.key.toString() == "code") code = entry.value.toString();
      if(entry.key.toString() == "hora") {
        List<String> split = entry.value.toString().split(":");
        hora = (int.parse(split.first), int.parse(split.last));
      }
    }
    return Recordatorio(tipoRecordatorio: reminder, hora: hora, codigo: code);
  }

}
