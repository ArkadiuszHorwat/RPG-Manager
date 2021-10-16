import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/features/players/widgets/players_list.dart';

final testPlayersData = [
  'tawroh',
  'kaio sakalena',
  'grunfeld',
  'slearoo',
  'nicky3',
  'michax',
  'Natergall21',
  'gruby123',
  'łysy321',
  'łysy321',
  'łysy321',
  'łysy321',
  'łysy321',
  'łysy321',
  'łysy321',
  'łysy321',
];

class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addPlayer(),
        Expanded(
          child: SingleChildScrollView(
            child: PlayersList(data: testPlayersData),
          ),
        ),
      ],
    );
  }

  Widget _addPlayer() {
    return Material(
      color: Colors.transparent,
      elevation: 2.5,
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Dodaj gracza',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 247, 241, 227),
                    ),
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.plus_app_fill,
                color: Color.fromARGB(255, 247, 241, 227),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
