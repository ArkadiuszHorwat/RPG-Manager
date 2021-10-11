import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:provider/provider.dart';
import 'package:rpg_manager/features/firebase/config.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class HomeScreenController {
  final _users =
      FlutterFirebaseConfig.getFirestoreConnect().collection('users');

  void onChoicePanelSelected(
      int choice, BuildContext context, User data) async {
    var _userSessionType = 'unknown';

    switch (choice) {
      case 1:
        _userSessionType = 'game master';
        break;
      case 2:
        _userSessionType = 'player';
        break;
    }
    await _users.doc(data.uid).update({'userSessionType': _userSessionType});
    final _userData = await _users.doc(data.uid);
    Navigator.of(context).pushNamed(RoutePageName.menu, arguments: _userData);
  }

  void exitLogOutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 247, 241, 227),
            title: Text(AppLocal.homeExitTitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonNoText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<FirebaseAuthentication>().signOut();
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonYesText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
