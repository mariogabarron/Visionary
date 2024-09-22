enum TipoRecordatorio { mensual, semanal }

class Recordatorio {
  TipoRecordatorio tipoRecordatorio;
  String codigo;
  (int, int) hora;
  Recordatorio({required this.tipoRecordatorio, required this.hora, required this.codigo});
}
