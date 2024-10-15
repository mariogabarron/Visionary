import 'package:firebase_database/firebase_database.dart';

/// La versión del esquema de la base de datos con la que es compatible. Si se introduce un asterisco, significa compatibilidad total.
const String compatibleDbScheme = "1.0";

/// Obtiene la versión de esquema de la base de datos.
Future<String> dbScheme() async {
  return (await FirebaseDatabase.instance.ref("info").child("db_scheme").get())
      .value
      .toString();
}

/// Determina si la versión v1 es estrictamente más reciente que la versión v2.
bool isGreaterVersion(String v1, String v2) {
  var numbers1 = v1.split(".").map((x) => int.parse(x));
  var numbers2 = v2.split(".").map((x) => int.parse(x));

  if (numbers1.elementAt(0) > numbers2.elementAt(0)) {
    return true;
  } else if (numbers1.elementAt(0) < numbers2.elementAt(0)) {
    return false;
  } else {
    if (numbers1.elementAt(1) > numbers2.elementAt(1)) {
      return true;
    } else {
      return false;
    }
  }
}

/// Determina si el esquema de la base de datos es compatible (válido) para la versión de la aplicación.
Future<bool> validScheme() async {
  if (compatibleDbScheme == "*") {
    return true;
  } else {
    return !isGreaterVersion(await dbScheme(), compatibleDbScheme);
  }
}
