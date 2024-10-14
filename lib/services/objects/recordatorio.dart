import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

enum TipoRecordatorio { mensual, semanal }

enum WeekDays { L, M, X, J, V, S, D }

class Recordatorio {
  TipoRecordatorio tipoRecordatorio;
  String codigo;
  (int, int) hora;
  Recordatorio(
      {required this.tipoRecordatorio,
      required this.hora,
      required this.codigo});

  static final Set<String> _keys = {
    'type',
    'code',
    'hora',
  };

  static TipoRecordatorio stringToReminder(String r) {
    if (r == "M") {
      return TipoRecordatorio.mensual;
    } else if (r == "S") {
      return TipoRecordatorio.semanal;
    }

    throw ArgumentError("The provided string was not a valid reminder.");
  }

  String _reminderToString() {
    if (tipoRecordatorio == TipoRecordatorio.mensual) return "M";
    else return "S";
  }

  static Future<Recordatorio> fromRef(DatabaseReference ref) async {
    TipoRecordatorio reminder = TipoRecordatorio.semanal;
    String code = "";
    (int, int) hora = (0, 0);
    for (var entry in (await ref.get()).children) {
      if (entry.key.toString() == "type") {
        reminder = stringToReminder(entry.value.toString());
      }
      if (entry.key.toString() == "code") code = entry.value.toString();
      if (entry.key.toString() == "hora") {
        List<String> split = entry.value.toString().split(":");
        hora = (int.parse(split.first), int.parse(split.last));
      }
    }
    return Recordatorio(tipoRecordatorio: reminder, hora: hora, codigo: code);
  }

  Set<WeekDays>? getWeekDays() {
    if (tipoRecordatorio == TipoRecordatorio.mensual) return null;
    Set<WeekDays> wd = <WeekDays>{};
    for (var char in codigo.split("")) {
      switch (char) {
        case 'L':
          wd.add(WeekDays.L);
          break;
        case 'M':
          wd.add(WeekDays.M);
          break;
        case 'X':
          wd.add(WeekDays.X);
          break;
        case 'J':
          wd.add(WeekDays.J);
          break;
        case 'V':
          wd.add(WeekDays.V);
          break;
        case 'S':
          wd.add(WeekDays.S);
          break;
        case 'D':
          wd.add(WeekDays.D);
          break;
      }
    }
    return wd;
  }

  Set<int>? getMonthDays() {
    if (tipoRecordatorio == TipoRecordatorio.semanal) return null;
    Set<int> md = <int>{};
    for (var month in codigo.split(";")) {
      md.add(int.parse(month));
    }
    return md;
  }

  void print() {
    int h = hora.$1;
    int m = hora.$2;
    log("Tipo de recordatorio: $tipoRecordatorio, código: $codigo, hora: ($h:$m)");
  }

  Object toDbScheme() {
    int h = hora.$1;
    int m = hora.$2;
    return {
      'type': _reminderToString(),
      'code': codigo,
      'hora': "$h:$m"
    };
  }
}
