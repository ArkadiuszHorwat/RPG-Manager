import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list.dart';

final testCharactersData = [
  'Tawroh Huiwart',
  'Kaio Sakalena',
  'Grunfeld',
  'Almerit',
  'Kerri',
  'Knypcio',
  'Palpuch',
];

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addCharacter(),
        Expanded(
          child: CharacterList(data: testCharactersData),
        ),
      ],
    );
  }

  Widget _addCharacter() {
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
                  AppLocal.charactersAddButton,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.appLight,
                    ),
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.plus_app_fill,
                color: AppColors.appLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}