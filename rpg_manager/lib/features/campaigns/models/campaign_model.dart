import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel {
  CampaignModel({
    required this.title,
    required this.system,
    this.campaignId,
    this.image,
    this.sessionType,
    this.gameMasterId,
    this.timestamp,
    this.sessionNumber,
    this.sessionStatus,
    this.description,
  });

  final String title;
  final String system;
  final String? campaignId;
  final String? image;
  final String? sessionType;
  final String? gameMasterId;
  final int? sessionNumber;
  final bool? sessionStatus;
  final Timestamp? timestamp;
  final String? description;
}
