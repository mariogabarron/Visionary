import 'package:firebase_database/firebase_database.dart';

enum TipoRecordatorio { mensual, semanal }

class Recordatorio {
  TipoRecordatorio tipoRecordatorio;
  String codigo;
  (int, int) hora;
  Recordatorio({required this.tipoRecordatorio, required this.hora, required this.codigo});


  static Future<Recordatorio> fromRef(DatabaseReference ref) {
    throw UnimplementedError("No implementado");
  }

}
