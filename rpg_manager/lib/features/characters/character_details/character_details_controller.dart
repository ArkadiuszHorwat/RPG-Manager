import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterDetailsScreenController {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCharacterDetails(
      {required String characterId}) {
    return FirebaseFirestore.instance
        .collection('characters')
        .doc(characterId)
        .snapshots();
  }
}
