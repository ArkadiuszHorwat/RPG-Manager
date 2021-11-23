import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsScreenController {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCharacterDetails(
      {required String characterId}) {
    return FirebaseFirestore.instance
        .collection('characters')
        .doc(characterId)
        .snapshots();
  }

  void _updateCharacter({
    required String characterId,
    required String updateTargetName,
    required String newValue,
  }) {
    try {
      CollectionReference characters =
          FirebaseFirestore.instance.collection('characters');

      characters
          .doc(characterId)
          .update({updateTargetName: newValue})
          .then((value) => print('$updateTargetName was updated'))
          .catchError((error) => print('Failed to update $updateTargetName'));
    } on Exception catch (e) {
      print('Coś poszło nie tak: $e');
    }
  }

  void _deleteCharacter({required String characterId}) {
    try {
      CollectionReference characters =
          FirebaseFirestore.instance.collection('characters');

      characters
          .doc(characterId)
          .delete()
          .then((value) => print('character was deleted'))
          .catchError((error) => print('Failed to delete character'));
    } on Exception catch (e) {
      print('Coś poszło nie tak: $e');
    }
  }

  void characterDelete(BuildContext context, {required String characterId}) {
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
                  'Napewno chcesz usunąć postać?',
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
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  _deleteCharacter(characterId: characterId);
                },
                child: Text(
                  'Tak',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Nie',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void atributeEditHandle(
    BuildContext context, {
    required String title,
    String? hintText,
    required String updateTargetName,
    required String characterId,
    String? characterMultiText,
    required String atributeType,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();
          final formKey = GlobalKey<FormState>();

          if (characterMultiText != null) {
            textController.text = characterMultiText;
          }

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
                Container(
                  height: characterMultiText != null ? 250 : 50,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: textController,
                      keyboardType: atributeType == 'number'
                          ? TextInputType.number
                          : TextInputType.multiline,
                      maxLines: 15,
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
                ),
                Divider(
                  color: AppColors.appDark,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _updateCharacter(
                    characterId: characterId,
                    updateTargetName: updateTargetName,
                    newValue: textController.text,
                  );
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
