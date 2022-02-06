import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.text,
    this.gameMasterId,
    this.timestamp,
  });

  final String title;
  final String text;
  final String? gameMasterId;
  final Timestamp? timestamp;
}
