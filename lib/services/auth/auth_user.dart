import 'package:firebase_auth/firebase_auth.dart' show User;
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
/// - Si el inicio de sesión es satisfactorio, devolverá los credenciales del usuario.
/// - Si ocurre un error, no se devolverán credenciales, y se devolverá una excepción que se podrá controlar.
Future<(UserCredential?, FirebaseAuthException?)> login_with_email(String email, String password) async {
  try {
    return (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password), null);
  }
  on FirebaseAuthException catch(e) {
    return (null, e);
  }
}


