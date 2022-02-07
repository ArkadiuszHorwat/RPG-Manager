import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg_manager/features/notifications/models/notification_model.dart';

class NotificationsCotroller {
  final noificationsSnapshot = FirebaseFirestore.instance
      .collection('notifications')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final notifications = FirebaseFirestore.instance.collection('notifications');

  Future<void> addNotification({
    required NotificationModel notificationModel,
  }) {
    return notifications.add({
      'title': notificationModel.title,
      'text': notificationModel.text,
      'gameMasterId': notificationModel.gameMasterId,
      'createdAt': notificationModel.timestamp,
    }).then((value) {
      print("Notification added");
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => print("Failed to add campaign: $error"));
  }

  Future<void> deleteNotifications() {
    return notifications.get().then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });
  }
}
