import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel {
  CampaignModel({
    required this.title,
    required this.system,
    this.image,
    required this.sessionType,
    required this.userId,
    required this.timestamp,
  });

  final String title;
  final String system;
  final String? image;
  final String sessionType;
  final String userId;
  final Timestamp timestamp;
}
