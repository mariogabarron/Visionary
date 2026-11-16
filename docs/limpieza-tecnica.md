# Revisión técnica de Visionary — 16 de noviembre de 2026

## Alcance

Limpieza local, sin commits ni pushes. Se conserva el cambio previo del usuario en `android/gradle/wrapper/gradle-wrapper.properties` (Gradle 9.7.1). No se modifican versiones, credenciales, configuración Firebase, reglas, rutas ni escrituras de base de datos. No se modifican estilos, diseños ni animaciones visibles.

## Eliminaciones autorizadas

- `Payload/`: exportación iOS compilada, aproximadamente 44 MB.
- `android/build/`: artefactos Gradle, aproximadamente 128 KB antes de validar. La compilación puede volver a generarlos.
- `.flutter-plugins 2` y `.flutter-plugins-dependencies 2`: copias de metadatos generados.
- `flutter_05.png` y `flutter_06.png`: archivos vacíos.

249 archivos versionados eliminados en total. El espacio del historial `.git` no se reduce con estas eliminaciones.

## Archivos modificados

- `.gitignore`: builds anidados, exportaciones de aplicaciones, cobertura, capturas de Flutter y copias numeradas de metadatos.
- `analysis_options.yaml`: excluye exclusivamente `my_backup_lib/**`, conservando el respaldo y evitando diagnósticos duplicados.
- `lib/main.dart`: elimina una inicialización redundante del binding.
- `lib/services/objects/objetivo_class.dart` y `tarea_class.dart`: `Future.wait` tipado devuelve directamente las listas; conserva las mismas lecturas, concurrencia, orden y propagación de errores.
- `lib/views/homepage/homepage_view.dart`: elimina un ticker infinito sin consumidores visuales y su import; libera el `ValueNotifier` y protege callbacks de conexión/anuncios después de desmontar la pantalla.
- `lib/views/homepage/creartareas_views/creartareados_view.dart`: elimina otro ticker infinito sin consumidores. La animación del fondo mantiene su controlador independiente.
- `lib/views/homepage/homepage_widgets/objetivos_row.dart`: evita callbacks tras desmontar la pantalla y obtiene una sola copia de la lista de objetivos por respuesta.
- `lib/views/homepage/homepage_widgets/progreso_container.dart`: mantiene un único listener y una curva liberable; descarta cargas completadas tras `dispose`. Conserva interpolación y duración de 500 ms.
- `lib/views/tutorial_inicio/tutorial_inicio.dart`: libera el `PageController`.
- `test/widget_test.dart`: sustituye el ejemplo del contador inexistente por pruebas de progreso y de finalización asíncrona tras desmontar. No utiliza servicios Firebase ni descargas de imágenes.

## Hallazgos conservados para revisión posterior

- `my_backup_lib/`: 27 archivos idénticos a `lib/` y 15 diferentes antes de los cambios. No es una copia íntegramente redundante. También se conserva `pubspec_backup.yaml`.
- Archivos Dart sin referencias desde `main.dart`: `services/db/db_info_provider.dart`, `views/auth_views/emailverify_view.dart` (vacío), `views/homepage/creartareas_views/creartareascuatro_view.dart`, `utilities/showdialogs/homepage/progreso_showdialog.dart`. Esta comprobación es de alcance estático, no una autorización para retirar funcionalidades.
- `Archive` está vacío; se conserva por no estar incluido en la eliminación autorizada.
- Imágenes de marca y `tutorialtres.png`: algunas no aparecen en el flujo actual, pero pueden servir de originales de diseño. Se conservan; `LOGOTIPOCONFONDO.png` se utiliza para generar el splash.
- No se retiran dependencias. `firebase_analytics` no tiene llamadas Dart directas, pero su plugin nativo puede recopilar eventos automáticamente. El resto tiene referencias en código o recursos.
- `Objetivo.fromRef`, `Tarea.getList` y `VisionaryUser.updateObjectives` realizan lecturas adicionales de hijos ya presentes en snapshots. Reutilizar snapshots podría reducir consultas, pero alteraría el momento de observación ante escrituras concurrentes; requiere pruebas específicas.
- `ObjetivosRow.initState` carga el usuario y luego lo recarga desde preferencias; unificar cargas requiere verificar selección y estados iniciales.
- El diálogo `porque_showdialog.dart` crea un controlador sin un propietario `State` que lo libere. Conviene extraer el contenido a un widget con ciclo de vida propio y probar el cierre durante la animación; liberarlo inmediatamente al completar `showDialog` podría ser prematuro.
- La inicialización de notificaciones está duplicada entre `main.dart` y `NotificationHandler`; no se cambia por su posible efecto en permisos e iconos.
- Es necesaria una validación visual en dispositivo y pruebas de integración Firebase para certificar todos los flujos.

## Validación

- `flutter analyze`: correcto, sin incidencias (210,1 s de análisis; la primera ejecución esperó lecturas del SDK).
- `dart analyze lib`: correcto, sin incidencias. Se repitió con permisos para el estado de Dart tras una restricción del sandbox.
- Prueba original: falló por inicialización Firebase y expectativas del contador de ejemplo inexistente.
- `flutter test --no-pub --reporter expanded`: 2 pruebas aprobadas, salida 0. Verifican valores de progreso, interpolación a mitad de la animación, actualizaciones sucesivas, lista vacía y finalización de una carga tras desmontar.
- `flutter build apk --debug --no-pub`: falla antes de compilar la aplicación, en `:gradle:compileKotlin`. El SDK Flutter 3.32.4 informa `Unresolved reference fileMode` en `FlutterPlugin.kt:715` y el uso obsoleto de `toLowerCase()` en `FlutterPluginUtils.kt:67`. El wrapper local apunta a Gradle 9.7.1. Revisar su compatibilidad en una tarea independiente, conservando el cambio previo del usuario.
- Formato de los archivos Dart modificados y `git diff --check`: correctos.
- `pubspec.yaml`, `pubspec.lock`, `firebase.json` y `lib/firebase_options.dart`: sin cambios.

Estas comprobaciones no sustituyen una prueba visual en dispositivo ni una prueba integral de Firebase. No se afirma que el APK compile ni que todos los flujos estén verificados.
