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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getSkills(
      {required String skillsId}) {
    return FirebaseFirestore.instance
        .collection('skills')
        .doc(skillsId)
        .snapshots();
  }

  final spellsSnapshot = FirebaseFirestore.instance
      .collection('spells')
      .orderBy('createdAt', descending: true)
      .snapshots();

  final itemsSnapshot = FirebaseFirestore.instance
      .collection('items')
      .orderBy('createdAt', descending: true)
      .snapshots();

  final proficienciesSnapshot = FirebaseFirestore.instance
      .collection('proficiencies')
      .orderBy('createdAt', descending: true)
      .snapshots();

  final featuresSnapshot = FirebaseFirestore.instance
      .collection('features')
      .orderBy('createdAt', descending: true)
      .snapshots();

  final inUseItemsSnapshot =
      FirebaseFirestore.instance.collection('inUseItems').snapshots();

  final spells = FirebaseFirestore.instance.collection('spells');
  final items = FirebaseFirestore.instance.collection('items');
  final features = FirebaseFirestore.instance.collection('features');
  final proficiencies = FirebaseFirestore.instance.collection('proficiencies');
  final inUseItems = FirebaseFirestore.instance.collection('inUseItems');

  Future<void> addSpell({
    required String name,
    required Timestamp timestamp,
    required String level,
    required String characterId,
    String? description,
  }) {
    return spells
        .add({
          'name': name,
          'createdAt': timestamp,
          'characterId': characterId,
          'description': description ?? "",
          'level': level,
        })
        .then((value) => print("Spell Added"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  Future<void> addItem({
    required String name,
    required Timestamp timestamp,
    required String characterId,
    String? description,
    required String pathName,
  }) {
    switch (pathName) {
      case 'itmes':
        return items
            .add({
              'name': name,
              'createdAt': timestamp,
              'characterId': characterId,
              'description': description ?? "",
            })
            .then((value) => print("Item Added"))
            .catchError((error) => print("Failed to add item: $error"));
      case 'features':
        return features
            .add({
              'name': name,
              'createdAt': timestamp,
              'characterId': characterId,
              'description': description ?? "",
            })
            .then((value) => print("Feature Added"))
            .catchError((error) => print("Failed to add feature: $error"));
      case 'proficiencies':
        return proficiencies
            .add({
              'name': name,
              'createdAt': timestamp,
              'characterId': characterId,
              'description': description ?? "",
            })
            .then((value) => print("Proficiencies Added"))
            .catchError(
                (error) => print("Failed to add proficiencies: $error"));
      default:
    }
    return items
        .add({
          'name': name,
          'createdAt': timestamp,
          'characterId': characterId,
          'description': description ?? "",
        })
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));
  }

  Future<void> addInUseItem({
    required String name,
    required String bonus,
    required String damage,
    required String damageType,
    required String characterId,
  }) {
    return inUseItems
        .add({
          'name': name,
          'characterId': characterId,
          'bonus': bonus,
          'damage': damage,
          'damageType': damageType,
        })
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));
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

  void _updateSkill({
    required String skillId,
    required String updateTargetName,
    required String newValue,
  }) {
    try {
      CollectionReference skills =
          FirebaseFirestore.instance.collection('skills');

      skills
          .doc(skillId)
          .update({updateTargetName: newValue})
          .then((value) => print('$updateTargetName was updated'))
          .catchError((error) => print('Failed to update $updateTargetName'));
    } on Exception catch (e) {
      print('Coś poszło nie tak: $e');
    }
  }

  void _updateItemsInUse({
    required String itemInUseId,
    required String updateTargetName,
    required String newValue,
    required String characterId,
    String? updateTargetNameSecond,
    String? newValueSecond,
  }) async {
    try {
      final inUseItems = FirebaseFirestore.instance.collection('inUseItems');

      updateTargetNameSecond != null
          ? inUseItems
              .doc(itemInUseId)
              .update({
                updateTargetName: newValue,
                updateTargetNameSecond: newValueSecond,
              })
              .then((value) => print(
                  '$updateTargetName $updateTargetNameSecond was updated'))
              .catchError((error) => print(
                  'Failed to update $updateTargetName $updateTargetNameSecond'))
          : inUseItems
              .doc(itemInUseId)
              .update({
                updateTargetName: newValue,
              })
              .then((value) => print('$updateTargetName was updated'))
              .catchError(
                  (error) => print('Failed to update $updateTargetName'));
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

  void _delete({
    required String id,
    required String collectionName,
  }) {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);

      collection
          .doc(id)
          .delete()
          .then((value) => print('$collectionName was deleted'))
          .catchError((error) => print('Failed to delete $collectionName'));
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

  void delete(
    BuildContext context, {
    required String id,
    required String collectionName,
    required String title,
  }) {
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _delete(
                    id: id,
                    collectionName: collectionName,
                  );
                  Navigator.pop(context);
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
    String? characterId,
    String? characterMultiText,
    required String atributeType,
    required String pathName,
    String? skillId,
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
                onPressed: pathName == 'character'
                    ? () {
                        _updateCharacter(
                          characterId: characterId ?? '',
                          updateTargetName: updateTargetName,
                          newValue: textController.text,
                        );
                        Navigator.pop(context);
                      }
                    : () {
                        _updateSkill(
                          skillId: skillId ?? '',
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

  void itemInUseEditHandle(
    BuildContext context, {
    required String title,
    String? hintText,
    String? hintTextSecond,
    String? updateTargetNameSecond,
    required String updateTargetName,
    required String itemInUseId,
    required String characterId,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();
          final formKey = GlobalKey<FormState>();
          final textControllerSecond = TextEditingController();

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
                  height: updateTargetNameSecond != null ? 150 : 50,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              TextFormField(
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
                              Divider(
                                color: AppColors.appDark,
                              ),
                            ],
                          ),
                          updateTargetNameSecond != null
                              ? Column(
                                  children: [
                                    TextFormField(
                                      controller: textControllerSecond,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: hintTextSecond,
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
                                    Divider(
                                      color: AppColors.appDark,
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _updateItemsInUse(
                    itemInUseId: itemInUseId,
                    updateTargetName: updateTargetName,
                    updateTargetNameSecond: updateTargetNameSecond,
                    newValue: textController.text,
                    newValueSecond: textControllerSecond.text,
                    characterId: characterId,
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
