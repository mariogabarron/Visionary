
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

const Set<String> keys = {
  'name',
  'email',
  'registered_on',
  'registered_tz',
  'registered_tz_offset',
  'country',
  'deleted',
  'last_login',
  'last_login_tz',
  'last_login_tz_offset',
  'objectives'
};

/// Comprueba si el usuario actual está registrado en la base de datos.
/// TODO: TESTEAR ESTA FUNCIÓN
Future<bool> userIsRegistered() async {
  if (FirebaseAuth.instance.currentUser != null) {
    if ((await FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).get()).exists) {
      List<Future<DataSnapshot>> futures = [];
      for (final entry in keys) {
        futures.add(FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).get());
      }
      await Future.wait(futures as Iterable<Future>);
      for (final entry in futures) {
        if (!(await entry).exists) {
          return false;
        }
      }
      return true;
    }
    else {
      return false;
    }
  }
  else {
    throw FirebaseAuthException(code: "user-not-found");
  }
}