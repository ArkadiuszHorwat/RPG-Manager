import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsSpells extends StatefulWidget {
  @override
  State<CharacterDetailsSpells> createState() => _CharacterDetailsSpellsState();
}

class _CharacterDetailsSpellsState extends State<CharacterDetailsSpells> {
  var spellsLvl = '0';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _listSpells(context: context),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _characterInfoCell(info: 'Cecha bazowa', value: 'Int'),
                _characterInfoCell(info: 'Komórki czarów', value: '5'),
                _characterInfoCell(info: 'Zużyte komórki', value: '2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _characterInfoCell(
                    info: 'St rzutu przeciw czarom', value: '16'),
                _characterInfoCell(info: 'Premia do ataku czarem', value: '+4'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _characterInfoCell({
    required String info,
    required String value,
  }) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Text(
            info,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appLight,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            clipBehavior: Clip.none,
            height: 60,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Center(
                child: Text(
              value,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _listSpells({
    required BuildContext context,
  }) {
    final _spells = <Widget>[];

    for (int i = 0; i <= 5; i++) {
      _spells.add(_spell());
    }

    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _spellListHeader(context: context),
            ],
          ),
          Container(
            height: 380,
            child: SingleChildScrollView(
              child: Column(
                children: _spells,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _spell() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'spell name',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appDark,
                fontSize: 16.0,
              ),
            ),
          ),
          Divider(
            color: AppColors.appDark,
          ),
        ],
      ),
    );
  }

  Widget _spellListHeader({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          _spellLvlEditHandle(context: context);
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.appDark,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'KRĄG',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Text(
                  spellsLvl,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _spellLvlEditHandle({required BuildContext context}) {
    final _spellsLvl = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  'Wybierz Krąg Czarów',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.appDark,
                ),
                DropdownButton(
                  value: spellsLvl,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30,
                  iconEnabledColor: AppColors.appDark,
                  items: _spellsLvl
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                  color: AppColors.appDark,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      spellsLvl = newValue!;
                    });
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  color: AppColors.appDark,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Wróć',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
