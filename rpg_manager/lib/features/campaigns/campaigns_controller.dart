import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

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
          'gameMasterId': campaignModel.gameMasterId,
          'image': campaignModel.image,
          'sessionType': campaignModel.sessionType,
          'createdAt': campaignModel.timestamp,
        })
        .then((value) => print("Campaing Added"))
        .catchError((error) => print("Failed to add campaign: $error"));
  }

  void routeToCampaignDetails(BuildContext context, String campaignId) {
    Navigator.of(context).pushNamed(
      RoutePageName.campaignDetailsPage,
      arguments: campaignId,
    );
  }
}
