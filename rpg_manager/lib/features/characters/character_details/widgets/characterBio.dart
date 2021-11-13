import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterBio extends StatelessWidget {
  CharacterBio({
    required this.characterId,
    required this.characterBio,
  });

  final String characterId;
  final String characterBio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            _bioEditHandle(context);
          },
          child: Container(
            height: 200,
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
                    Text(
                      'Biografia',
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
                    Text(
                      characterBio,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _bioEditHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final formKey = GlobalKey<FormState>();
          final textController = TextEditingController();
          textController.text = characterBio;

          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  'Edytuj biografie',
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
                  height: 250,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      maxLines: 15,
                      controller: textController,
                      keyboardType: TextInputType.multiline,
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
                onPressed: () async {
                  try {
                    CollectionReference characters =
                        FirebaseFirestore.instance.collection('characters');

                    characters
                        .doc('$characterId')
                        .update({'bio': textController.text})
                        .then((value) => print('bio was updated'))
                        .catchError((error) => print('Failed to update bio'));
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
