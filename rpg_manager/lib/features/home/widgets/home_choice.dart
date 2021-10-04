import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/firebase/config.dart';
import 'package:rpg_manager/features/home/widgets/home_choice_item.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class HomeChoice extends StatefulWidget {
  HomeChoice({
    Key? key,
    required this.data,
  }) : super(key: key);

  final User data;

  @override
  _HomeChoiceState createState() => _HomeChoiceState();
}

class _HomeChoiceState extends State<HomeChoice> {
  final _users =
      FlutterFirebaseConfig.getFirestoreConnect().collection('users');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeChoiceItem(
              title: 'PANEL MISTRZA GRY',
              imagePath: 'lib/app_assets/images/mistrz-gry-img.jpg',
              actionRoute: () => _onChoicePanelSelected(1),
            ),
            SizedBox(
              height: 10,
            ),
            HomeChoiceItem(
              title: 'PANEL GRACZA',
              imagePath: 'lib/app_assets/images/gracz-img.jpg',
              actionRoute: () => _onChoicePanelSelected(2),
            ),
          ],
        ),
      ),
    );
  }

  void _onChoicePanelSelected(int choice) async {
    var _userSessionType = 'unknown';

    switch (choice) {
      case 1:
        _userSessionType = 'game master';
        break;
      case 2:
        _userSessionType = 'player';
        break;
    }
    await _users
        .doc(widget.data.uid)
        .update({'userSessionType': _userSessionType});
    final _userData = await _users.doc(widget.data.uid);
    Navigator.of(context).pushNamed(RoutePageName.menu, arguments: _userData);
  }
}
