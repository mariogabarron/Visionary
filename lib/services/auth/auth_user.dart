import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
@immutable
class AuthUser {
  final String? email;
  final bool isVerified;
  const AuthUser({required this.email, required this.isVerified});
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isVerified: user.emailVerified, email: user.email);
}
*/

/// Inicia sesión con email y contraseña, y devuelve los credenciales del usuario y una excepción no simultáneamente nulables.
/// - Si el inicio de sesión es satisfactorio, devolverá los credenciales del usuario en la primera posición de la tupla.
/// - Si ocurre un error, no se devolverán credenciales, y se devolverá una excepción [FirebaseAuthException] que se podrá controlar.
Future<(UserCredential?, FirebaseAuthException?)> login_with_email(String email, String password) async {
  try {
    return (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password), null);
  }
  on FirebaseAuthException catch(e) {
    return (null, e);
  }
}

/// Crea un usuario con email y contraseña, enviando el email de confirmación al correo electrónico dado, y guardando su nombre en la base de datos.
/// - Si la función termina satisfactoriamente, se realiza un logout para que no se inicie sesión sin estar verificado el usuario. Se devuelve null.
/// - Si la función tiene un error, se devuelve la [FirebaseAuthException] resultante del error.
/// - Si la función tiene un error debido a que ya existe un usuario registrado con ese email, antes de lanzar un error, reenvía el correo de confirmación.
Future<FirebaseAuthException?> register_with_email(String name, String email, String password) async {
  try {
    var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await cred.user?.sendEmailVerification();
    await FirebaseDatabase.instance.ref("users").child(cred.user!.uid).set({"name":name});
    await FirebaseAuth.instance.signOut();
    return null;
  }
  on FirebaseAuthException catch(e) {
    print(e.code);
    if(e.code == "email-already-in-use") {
      var a = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      a.user?.sendEmailVerification();
    }
    return e;
  }
}