import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterInfo extends StatelessWidget {
  CharacterInfo({
    required this.system,
    required this.characterId,
    required this.characterRace,
    required this.characterClass,
    required this.characterAlignment,
  });

  final String system;
  final String characterId;
  final String characterRace;
  final String characterClass;
  final String characterAlignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            'Informacje o postaci:',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoCell(
                      title: 'Rasa',
                      infoType: characterRace,
                      action: () => _infoEditHandle(
                        context,
                        title: 'Edytuj rase',
                        hintText: 'Rasa',
                        updateTargetName: 'race',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Klasa',
                      infoType: characterClass,
                      action: () => _infoEditHandle(
                        context,
                        title: 'Edytuj klase',
                        hintText: 'Klasa',
                        updateTargetName: 'class',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Charakter',
                      infoType: characterAlignment,
                      action: () => _infoEditHandle(
                        context,
                        title: 'Edytuj charakter',
                        hintText: 'Charakter',
                        updateTargetName: 'alignment',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Aktualna przygoda',
                      infoType: 'Comarch',
                      action: () {},
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'System',
                      infoType: system,
                      action: () {},
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCell({
    required String title,
    required VoidCallback action,
    required String infoType,
  }) {
    return GestureDetector(
      onTap: action,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 14.0,
                ),
              ),
            ),
            Text(
              infoType,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _infoEditHandle(
    BuildContext context, {
    required String title,
    required String hintText,
    required String updateTargetName,
  }) {
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
                  title,
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
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
                    CollectionReference characters =
                        FirebaseFirestore.instance.collection('characters');

                    characters
                        .doc('$characterId')
                        .update({updateTargetName: textController.text})
                        .then((value) => print('$updateTargetName was updated'))
                        .catchError((error) =>
                            print('Failed to update $updateTargetName'));
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Zapisz',
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
