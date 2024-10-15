import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/db/db_user_management.dart';

class VisionaryUser {
  final String _name;
  final String _email;
  final String _country;
  List<(String, DatabaseReference)> _objectives;
  /*
  static const Set<String> _keys = {
    'name',
    'email',
    'registered_on',
    'registered_offset',
    'country',
    'objectives'
  };
  */

  VisionaryUser(
      {required name, required email, required country, required objectives})
      : _name = name,
        _country = country,
        _objectives = objectives,
        _email = email;

  /// Obtiene el VisionaryUser que ha iniciado sesión.
  /// PRECONDICIÓN: El usuario debe haber iniciado sesión.
  static Future<VisionaryUser> fromLogin() async {
    assert(userRoute() != null);
    var data = userRoute()!.get();
    String name = "", country = "", email = "";
    List<(String, DatabaseReference)> objectives = [];
    for (final entry in (await data).children) {
      if (entry.key == "name") name = entry.value.toString();
      if (entry.key == "country") country = entry.value.toString();
      if (entry.key == "email") email = entry.value.toString();
      if (entry.key == "objectives") {
        for (final obj in entry.children) {
          final objName = obj.child("name").value.toString();
          final objRef = obj.ref;
          objectives.add((objName, objRef));
        }
      }
    }
    return VisionaryUser(
        name: name, email: email, country: country, objectives: objectives);
  }

  String get name => _name;

  String get email => _email;

  String get country => _country;

  List<(String, DatabaseReference)> get objectives => List.from(_objectives);

  /// Actualiza la lista de objetivos del VisionaryUser
  void updateObjectives() async {
    List<(String, DatabaseReference)> list = [];
    for (var entry in (await userRoute()!.child("objectives").get()).children) {
      list.add(
          ((await entry.ref.child("name").get()).value.toString(), entry.ref));
    }
    _objectives = list;
  }
}
