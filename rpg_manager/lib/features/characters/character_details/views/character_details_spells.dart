import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsSpells extends StatefulWidget {
  @override
  State<CharacterDetailsSpells> createState() => _CharacterDetailsSpellsState();
}

class _CharacterDetailsSpellsState extends State<CharacterDetailsSpells> {
  int spellsLvl = 0;

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
                _characterInfoCell(info: 'cecha bazowa', value: 'Int'),
                _characterInfoCell(info: 'Komórki czarów', value: '5'),
                _characterInfoCell(info: 'Zużyte komórki', value: '2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _characterInfoCell(
                    info: 'st rzutu przeciw czarom', value: '16'),
                _characterInfoCell(info: 'premia do ataku czarem', value: '+4'),
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
            height: 70,
            width: 100,
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
    return Container(
      clipBehavior: Clip.none,
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
                children: [
                  _spell(),
                  _spell(),
                  _spell(),
                  _spell(),
                  _spell(),
                  _spell(),
                  _spell(),
                ],
              ),
            ),
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
          _infoEditHandle(context: context);
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
                  spellsLvl.toString(),
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

  Widget _spell() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'asd',
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
        ],
      ),
    );
  }

  void _infoEditHandle({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();
          final formKey = GlobalKey<FormState>();
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
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Krąg',
                      hintStyle: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    autofocus: false,
                    validator: (text) {
                      if (text != null) {
                        print('fajen');
                      } else {
                        print('niefajen');
                        return '';
                      }
                    },
                  ),
                ),
                Divider(
                  color: AppColors.appDark,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  try {
                    setState(() {
                      spellsLvl = int.parse(textController.text);
                    });
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Wybierz',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
