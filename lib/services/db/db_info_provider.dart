import 'package:firebase_database/firebase_database.dart';

const String COMPATIBLE_DB_SCHEME = "1.0";

Future<String> dbScheme() async {
  return (await FirebaseDatabase.instance.ref("info").child("db_scheme").get()).value.toString();
}

bool isGreaterVersion(String v1, String v2) {
  var numbers1 = v1.split(".").map((x) => int.parse(x));
  var numbers2 = v2.split(".").map((x) => int.parse(x));

  if(numbers1.elementAt(0) > numbers2.elementAt(0)) return true;
  else if (numbers1.elementAt(0) < numbers2.elementAt(0)) return false;
  else {
    if(numbers1.elementAt(1) > numbers2.elementAt(1)) return true;
    else return false;
  }
}

Future<bool> validScheme() async {
  if(COMPATIBLE_DB_SCHEME == "*") return true;
  else {
    return ! isGreaterVersion(await dbScheme(), COMPATIBLE_DB_SCHEME);
  }
}