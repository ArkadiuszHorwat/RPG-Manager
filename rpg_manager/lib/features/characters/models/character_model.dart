import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterModel {
  CharacterModel({
    required this.name,
    required this.system,
    this.image,
    required this.userId,
    required this.timestamp,
  });

  final String name;
  final String system;
  final String? image;
  final String userId;
  final Timestamp timestamp;
}
