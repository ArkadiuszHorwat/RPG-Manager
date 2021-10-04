import 'package:flutter/cupertino.dart';

class PlayersListScreen extends StatefulWidget {
  @override
  _PlayersListScreenState createState() => _PlayersListScreenState();
}

class _PlayersListScreenState extends State<PlayersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Lista graczy',
      ),
    );
  }
}
