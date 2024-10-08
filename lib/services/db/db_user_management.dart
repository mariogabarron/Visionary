import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:visionary/services/auth/auth_user.dart';

const Set<String> keys = {
  'name',
  'email',
  'registered_on',
  'registered_offset',
  'country',
  'deleted',
  'last_login',
  'last_login_offset',
  'app_version'
};

DatabaseReference? userRoute() {
  if(FirebaseAuth.instance.currentUser == null) {
    return null;
  } else {
    return FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid);
  }
}

/// Comprueba si el usuario actual está registrado en la base de datos.
/// PRECONDICION: Debe haberse iniciado sesión en Firebase
Future<bool> userIsRegistered() async {
  assert(currentUser != null);
    if ((await userRoute()?.get())!.exists) {
      List<Future<DataSnapshot>> futures = [];
      for (final entry in keys) {
        futures.add(userRoute()!.child(entry).get());
      }
      await Future.wait(futures as Iterable<Future>);
      for (final entry in futures) {
        if (!(await entry).exists) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }

}

/// Registra al usuario en la base de datos.
/// PRECONDICION: Debe haberse iniciado sesión en Firebase
Future<void> registerUser(String name) async {
  assert(currentUser != null);
  var packageInfo = PackageInfo.fromPlatform();
  var user = currentUser!;
  var route = userRoute()!;
  var now = DateTime.now().toUtc().toIso8601String();
  var nowTz = DateTime.now().timeZoneOffset.inHours;
    await route.update( {
      "name": name,
      "email": user.email,
      "registered_on": now,
      "registered_offset": nowTz,
      "country": await getUserCountry,
      "deleted": false,
      "last_login": now,
      "last_login_offset": nowTz,
      "app_version": (await packageInfo).version
    });

}

/// Actualiza la fecha de inicio de sesión del usuario.
/// PRECONDICION: Debe haberse iniciado sesión en Firebase
Future<void> updateLogin() async {
  assert(currentUser !=  null);
  var route = userRoute()!;
  var now = DateTime.now().toUtc().toIso8601String();
  var nowTz = DateTime.now().timeZoneOffset.inHours;

  await route.update({
    "last_login": now,
    "last_login_offset" : nowTz,
    "app_version": (await PackageInfo.fromPlatform()).version
  });
}