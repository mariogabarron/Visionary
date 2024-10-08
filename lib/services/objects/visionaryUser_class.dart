import 'package:firebase_database/firebase_database.dart';
import 'package:visionary/services/db/db_user_management.dart';
import 'package:visionary/services/objects/objetivo_class.dart';

class VisionaryUser {
  String _name;
  String _email;
  String _country;
  List<(String, DatabaseReference)> _objectives;

  static const Set<String> _keys = {
    'name',
    'email',
    'registered_on',
    'registered_offset',
    'country',
    'objectives'
  };

  VisionaryUser({required name, required email, required country, required objectives}) :
      _name = name, _country = country, _objectives = objectives, _email = email;

  /// Obtiene el VisionaryUser que ha iniciado sesión.
  static Future<VisionaryUser> fromLogin() async {
    var data = userRoute()!.get();
    String name = "", country = "", email = "";
    List<(String, DatabaseReference)> objectives = [];
    for(final entry in (await data).children) {
      if(entry.key == "name") name = entry.value.toString();
      if(entry.key == "country") country = entry.value.toString();
      if(entry.key == "email") email = entry.value.toString();
      if(entry.key == "objectives") {
        for (final obj in entry.children) {
          objectives.add( (obj.children.where( (x) => x.key =="name").first.value.toString(), obj.ref) );
        }
      }
    }
    return VisionaryUser(name: name, email: email, country: country, objectives: objectives);
  }

  String get name => _name;

  String get email => _email;

  String get country => _country;

  List<(String, DatabaseReference)> get objectives => _objectives;

}