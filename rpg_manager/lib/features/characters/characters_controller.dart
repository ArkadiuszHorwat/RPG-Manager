import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharactersScreenController {
  final campaignsSnapshot = FirebaseFirestore.instance
      .collection('characters')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final campaigns = FirebaseFirestore.instance.collection('characters');

  Future<void> addCharacter({
    required CharacterModel characterModel,
  }) {
    return campaigns
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
}
