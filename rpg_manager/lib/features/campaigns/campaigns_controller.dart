import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignsScreenController {
  final campaignsSnapshot = FirebaseFirestore.instance
      .collection('campaigns')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final campaigns = FirebaseFirestore.instance.collection('campaigns');

  Future<void> addCampaigns({
    required String title,
    required String system,
    required String? image,
    required String sessionType,
    required String userId,
    required Timestamp timestamp,
  }) {
    return campaigns
        .add({
          'title': title,
          'system': system,
          'usersId': [userId],
          'image': image,
          'sessionType': sessionType,
          'createdAt': timestamp,
        })
        .then((value) => print("Campaing Added"))
        .catchError((error) => print("Failed to add campaign: $error"));
  }
}
