import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterImage extends StatelessWidget {
  CharacterImage({
    this.image,
    required this.characterId,
    this.characterPD,
    required this.characterLvl,
  });

  final String? image;
  final String characterId;
  final String? characterPD;
  final int characterLvl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _imageEditHandle(context);
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                image: image == null || !File(image!).existsSync()
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'lib/app_assets/images/character-img.jpg',
                        ),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(image!)),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => _experiencePointsInfo(context),
              child: Container(
                clipBehavior: Clip.none,
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: AppColors.appLight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3,
                      spreadRadius: 0.5,
                    ),
                  ],
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  characterLvl.toString(),
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 28.0,
                    ),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _imageEditHandle(BuildContext context) {
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
                  'Edytuj obraz',
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
                onPressed: () async {
                  try {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    final imageFromGallery = await File(image.path);

                    CollectionReference characters =
                        FirebaseFirestore.instance.collection('characters');

                    characters
                        .doc('$characterId')
                        .update({'image': imageFromGallery.path})
                        .then((value) => print('image was updated'))
                        .catchError((error) => print('Failed to update image'));
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Zmień',
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
                  CollectionReference characters =
                      FirebaseFirestore.instance.collection('characters');

                  characters
                      .doc('$characterId')
                      .update({'image': FieldValue.delete()})
                      .then((value) => print('image deleted'))
                      .catchError((error) => print('Failed to delete image'));
                  Navigator.pop(context);
                },
                child: Text(
                  'Usuń',
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

  void _experiencePointsInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var editOpen = false;
          return StatefulBuilder(
              builder: (context, StateSetter setDialogState) {
            final formKey = GlobalKey<FormState>();
            final _textController = TextEditingController();

            return AlertDialog(
              backgroundColor: AppColors.appLight,
              title: Column(
                children: [
                  Divider(
                    color: AppColors.appDark,
                  ),
                  Text(
                    'Punkty doświadczenia',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  editOpen == false
                      ? Text(
                          characterPD!.isEmpty ? '0' : characterPD!,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: _textController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Ilość punktów doświadczenia',
                              hintStyle: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14,
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
                  TextButton(
                    onPressed: editOpen == false
                        ? () {
                            CollectionReference characters = FirebaseFirestore
                                .instance
                                .collection('characters');

                            characters
                                .doc('$characterId')
                                .update({'level': characterLvl + 1})
                                .then((value) => print('Lvl updated'))
                                .catchError(
                                    (error) => print('Failed to update Lvl'));
                            Navigator.pop(context);
                          }
                        : () {},
                    child: Text(
                      'Dodaj poziom',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: editOpen == false
                              ? AppColors.appDark
                              : Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                  TextButton(
                    onPressed: editOpen == false
                        ? () {
                            if (characterLvl > 0) {
                              CollectionReference characters = FirebaseFirestore
                                  .instance
                                  .collection('characters');

                              characters
                                  .doc('$characterId')
                                  .update({'level': characterLvl - 1})
                                  .then((value) => print('Lvl updated'))
                                  .catchError(
                                      (error) => print('Failed to update Lvl'));
                              Navigator.pop(context);
                            }
                          }
                        : () {},
                    child: Text(
                      'Odejmij poziom',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: editOpen == false
                              ? AppColors.appDark
                              : Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                ],
              ),
              actions: [
                editOpen == false
                    ? TextButton(
                        onPressed: () {
                          setDialogState(() => editOpen = true);
                        },
                        child: Text(
                          'Edytuj',
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          CollectionReference characters = FirebaseFirestore
                              .instance
                              .collection('characters');

                          characters
                              .doc('$characterId')
                              .update({'characterPD': _textController.text})
                              .then((value) => print('PD updated'))
                              .catchError(
                                  (error) => print('Failed to update PD'));

                          Navigator.pop(context);
                          setDialogState(() => editOpen = false);
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
        });
  }
}
