import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';

class CharacterImage extends StatelessWidget {
  CharacterImage({
    this.image,
    required this.characterId,
  });

  final String? image;
  final String characterId;

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
                borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
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
                      BorderRadiusDirectional.all(Radius.circular(20)),
                ),
                child: Center(
                    child: Text(
                  '0',
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
                  'Edytować obrazek?',
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
                },
                child: Text(
                  AppLocal.commonNoText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
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
                  AppLocal.commonYesText,
                  style: TextStyle(
                    color: Colors.black,
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
                  'Usuń obraz',
                  style: TextStyle(
                    color: Colors.black,
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
                Text(
                  '1550',
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
          );
        });
  }
}
