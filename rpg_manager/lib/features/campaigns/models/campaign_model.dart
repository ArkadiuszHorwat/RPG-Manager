import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel {
  CampaignModel({
    required this.title,
    required this.system,
    this.image,
    this.sessionType,
    this.gameMasterId,
    this.timestamp,
    this.sessionNumber,
  });

  final String title;
  final String system;
  final String? image;
  final String? sessionType;
  final String? gameMasterId;
  final int? sessionNumber;
  final Timestamp? timestamp;
}
