import 'package:flutter/widgets.dart';
import 'package:rpg_manager/features/firebase/config.dart';

class Setup {
  Setup();

  static Future<void> setupInitialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterFirebaseConfig.initialize();
  }
}
