import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';

class CampaignsScreenController {
  final campaignsSnapshot = FirebaseFirestore.instance
      .collection('campaigns')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final campaigns = FirebaseFirestore.instance.collection('campaigns');

  Future<void> addCampaigns({
    required CampaignModel campaignModel,
  }) {
    return campaigns
        .add({
          'title': campaignModel.title,
          'system': campaignModel.system,
          'usersId': [campaignModel.userId],
          'image': campaignModel.image,
          'sessionType': campaignModel.sessionType,
          'createdAt': campaignModel.timestamp,
        })
        .then((value) => print("Campaing Added"))
        .catchError((error) => print("Failed to add campaign: $error"));
  }
}
