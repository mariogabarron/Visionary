import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final String? email;
  final bool isVerified;
  const AuthUser({required this.email, required this.isVerified});
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isVerified: user.emailVerified, email: user.email);
}
