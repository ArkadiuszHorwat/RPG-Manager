import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterDetailsScreenController {
  DocumentReference<Map<String, dynamic>> getCharacterDetails(
      {required String characterId}) {
    return FirebaseFirestore.instance.collection('characters').doc(characterId);
  }
}
