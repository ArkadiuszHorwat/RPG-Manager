import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class CharactersScreenController {
  final charactersSnapshot = FirebaseFirestore.instance
      .collection('characters')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final characters = FirebaseFirestore.instance.collection('characters');
  final skills = FirebaseFirestore.instance.collection('skills');

  Future<void> addCharacter({
    required CharacterModel characterModel,
  }) {
    return skills.add({
      'acrobatics': '',
      'animalHandling': '',
      'arcana': '',
      'athletics': '',
      'deception': '',
      'history': '',
      'insight': '',
      'intimidation': '',
      'investigation': '',
      'medicine': '',
      'nature': '',
      'perception': '',
      'performance': '',
      'persuasion': '',
      'religion': '',
      'sleightOfHand': '',
      'stealth': '',
      'survival': '',
    }).then((value) {
      print("Skills Added");
      characters
          .add({
            'name': characterModel.name,
            'system': characterModel.system,
            'userId': characterModel.userId,
            'image': characterModel.image,
            'createdAt': characterModel.timestamp,
            'skillsId': value.id,
          })
          .then((value) => print("Character Added"))
          .catchError((error) => print("Failed to add character: $error"));
    });
  }

  void routeToCharacterDetails(BuildContext context, Map<String, dynamic> ids) {
    Navigator.of(context).pushNamed(
      RoutePageName.characterDetailsPage,
      arguments: ids,
    );
  }
}
