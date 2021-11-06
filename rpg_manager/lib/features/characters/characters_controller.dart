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

  Future<void> addCharacter({
    required CharacterModel characterModel,
  }) {
    return characters
        .add({
          'name': characterModel.name,
          'system': characterModel.system,
          'userId': characterModel.userId,
          'image': characterModel.image,
          'createdAt': characterModel.timestamp,
        })
        .then((value) => print("Character Added"))
        .catchError((error) => print("Failed to add character: $error"));
  }

  void routeToCharacterDetails(BuildContext context, String characterId) {
    Navigator.of(context).pushNamed(
      RoutePageName.characterDetailsPage,
      arguments: characterId,
    );
  }
}
