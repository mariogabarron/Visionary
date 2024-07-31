enum TipoPeriodicidad { mensual, semanal, diario }

class Periodicidad {
  TipoPeriodicidad tipoPeriodicidad;
  int veces;
  Periodicidad({required this.tipoPeriodicidad, required this.veces});
}
