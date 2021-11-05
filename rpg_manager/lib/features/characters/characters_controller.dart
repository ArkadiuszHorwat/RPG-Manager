import 'package:cloud_firestore/cloud_firestore.dart';

class CharactersScreenController {
  final campaignsSnapshot = FirebaseFirestore.instance
      .collection('characters')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final campaigns = FirebaseFirestore.instance.collection('characters');

  Future<void> addCharacter({
    required String name,
    required String system,
    required String? image,
    required String userId,
    required Timestamp timestamp,
  }) {
    return campaigns
        .add({
          'name': name,
          'system': system,
          'userId': userId,
          'image': image,
          'createdAt': timestamp,
        })
        .then((value) => print("Character Added"))
        .catchError((error) => print("Failed to add character: $error"));
  }
}
