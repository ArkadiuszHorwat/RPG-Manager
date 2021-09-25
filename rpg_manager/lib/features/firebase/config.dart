import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FlutterFirebaseConfig {
  FlutterFirebaseConfig();

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static Future<DatabaseReference> getDatabaseConnect(
      {required String path}) async {
    final _databaseURL =
        'https://rpg-manager-fb2a1-default-rtdb.europe-west1.firebasedatabase.app';

    final _fireTest = await FirebaseDatabase(
      databaseURL: _databaseURL,
    ).reference().child(path);

    return _fireTest;
  }
}
