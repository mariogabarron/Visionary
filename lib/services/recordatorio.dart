enum TipoRecordatorio { periodico, semanal }

class Recordatorio {
  TipoRecordatorio tipoRecordatorio;
  List<int> hora;
  Recordatorio({required this.tipoRecordatorio, required this.hora});
}
