**Documento por terminar**

# Recordatorio (reminder)
## Descripción
Asignado a una tarea específica, indica cuándo se debe enviar notificaciones al usuario para cumplirla.
## Valores
#### Tipo: ENUM{Periodico, Semanal} no nulo
Indica si el recordatorio se realiza cada cierto número de días (periódico) o ciertos días de la semana (semanal)
#### Periodicidad: String no nulo.
Formato que codifica según el Tipo:
- Si el recordatorio es periódico, el string será un número entero mayor que 0 que representa cada cuántos días se notifica al usuario.
- Si el recordatorio es semanal, el string será una cadena formada por los carácteres 'L', 'M', 'X', 'J', 'V', 'S' y 'D' que indican qué días se notifica al usuario.
#### Hora: Entero\[2] no nulo cuyo primer elemento está en el intervalo \[0, 23] y cuyo segundo elemento está en el intervalo \[0, 59]
Hora del día a la que se mandará la notificación al usuario.
- ¿Por qué no se usa un DateTime como tipo de dato para esta variable? DateTime es una clase que considero demasiado pesada para guardar una hora con hora y minuto, ya que es un formato capaz de almacenar desde fecha exacta hasta milisegundos.
- Conviene usar dos enteros de 16 bits (solo si no es mucha molestia implementarlo así) para optimizar memoria, ya que la cardinalidad de los intervalos es muy pequeña para los enteros de 32 bits.
# Periodicidad (period)
## Descripción
Asignado a una tarea específica, indica cuántas veces ha de cumplirse esa tarea, y cuándo. No necesita CLAVE, ya que es única en cada tarea.
## Valores
#### Tipo: ENUM{Mensual, Semanal, Diario} no nulo.
Tipo enumerado que indica si la periodicidad es de tipo mensual, semanal o diaria.
#### Veces: Entero no nulo mayor que 0.
Indica cuántas veces debe cumplirse esta tarea.

# Tarea (task)
## Descripción
Representa una tarea del usuario, perteneciente a un objetivo.
## Valores
#### \[CLAVE] Nombre: String no nulo entre 1 y 20 carácteres.
Nombre del objetivo.
#### Prioridad: Entero no nulo entre 1 y 5.
Entero que indica cuán prioritaria es la tarea. Recordemos que si la tarea es periódica, el peso se multiplica por cada ocurrencia.
#### Periodicidad: Periodicidad nulable.
Indica cuántas veces y cuándo se debe cumplir esta tarea. Si es nulo, la tarea no es periódica.
#### Recordatorio: Recordatorio nulable.
Indica en qué momentos se ha de notificar al usuario el cumplimiento de la tarea. Si es nulo, la tarea nunca será notificada.
