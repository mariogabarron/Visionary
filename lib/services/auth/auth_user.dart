import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as devtools show log;
import 'package:http/http.dart' as http;
import 'package:visionary/services/db/db_user_management.dart';

class VisionaryUser {
  final String email;
  final String name;
  final String countryCode;
  const VisionaryUser(
      {required this.email, required this.name, required this.countryCode});
}

/// Obtiene el código del país del usuario por IP.
Future<String> get getUserCountry async {
  final response = await http.get(Uri.parse('http://ip-api.com/json'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['country'];
  } else {
    return "null";
  }
}

/// Devuelve el usuario que hay actualmente registrado.
User? get currentUser {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user;
  } else {
    return null;
  }
}

/// Inicia sesión con email y contraseña, y devuelve los credenciales del usuario y una excepción no simultáneamente nulables.
/// - Si el inicio de sesión es satisfactorio, devolverá los credenciales del usuario en la primera posición de la tupla.
/// - Si ocurre un error, no se devolverán credenciales, y se devolverá una excepción [FirebaseAuthException] que se podrá controlar.
Future<(UserCredential?, FirebaseAuthException?)> loginWithEmail(
    String email, String password) async {
  try {
    return (
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password),
      null
    );
  } on FirebaseAuthException catch (e) {
    return (null, e);
  }
}

/// Crea un usuario con email y contraseña, enviando el email de confirmación al correo electrónico dado, y guardando su nombre en la base de datos.
/// - Si la función termina satisfactoriamente, se realiza un logout para que no se inicie sesión sin estar verificado el usuario. Se devuelve null.
/// - Si la función tiene un error, se devuelve la [FirebaseAuthException] resultante del error.
/// - Si la función tiene un error debido a que ya existe un usuario registrado con ese email, antes de devolver el error error, reenvía el correo de confirmación.
Future<FirebaseAuthException?> registerWithEmail(
    String name, String email, String password) async {
  try {
    var cred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await cred.user?.sendEmailVerification();
    await registerUser(name);
    await FirebaseAuth.instance.signOut();
    return null;
  } on FirebaseAuthException catch (e) {
    devtools.log(e.code);
    if (e.code == "email-already-in-use") {
      var a = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await a.user?.sendEmailVerification();
    }
    return e;
  }
}

/// Lanza el inicio de sesión de Google.
/// - Si el usuario cancela el inicio de sesión, se devuelve (null, null)
/// - Si el usuario inicia sesión con google sin errores, se devuelven los credenciales en la primera posición de la tupla, y un null en la segunda.
/// - Si sucede un error al iniciar sesión con Google, se devuelve la [FirebaseAuthException] resultante en la segunda posición, y un null en la primera.
Future<(UserCredential?, FirebaseAuthException?)> loginWithGoogle() async {
  var googleAccount = await GoogleSignIn().signIn();
  if (googleAccount != null) {
    try {
      GoogleSignInAuthentication auth = await googleAccount.authentication;
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: auth.idToken, accessToken: auth.accessToken));
      // Comprueba si el nombre ya está escrito, y lo cambio si no existe.
      if (!await userIsRegistered()) {
        registerUser(userCredential.user!.displayName!);
      }

      return (userCredential, null);
    } on FirebaseAuthException catch (e) {
      return (null, e);
    }
  } else {
    return (null, null);
  }
}

Future<void> logOut() async {
  final user = currentUser;
  if (user != null) {
    await FirebaseAuth.instance.signOut();
    devtools.log("Cierre de sesión exitoso");
  } else {
    devtools.log("User not logged in auth exception");
  }
}

Future<void> deleteAccount() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      await user.delete();
      devtools.log("Usuario eliminado");
    } on FirebaseAuthException catch (e) {
      devtools.log("Error al eliminar usuario: ${e.message}");
    } catch (e) {
      devtools.log("Error inesperado: ${e.toString()}");
    }
  } else {
    devtools.log("User doesn't exist");
  }
}
