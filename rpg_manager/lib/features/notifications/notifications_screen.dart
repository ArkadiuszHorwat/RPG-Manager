import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/notifications/models/notification_model.dart';
import 'package:rpg_manager/features/notifications/notifications_controller.dart';
import 'package:rpg_manager/widgets/app_loading_screen.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({
    required this.userId,
  });

  final String userId;

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _controller = NotificationsCotroller();

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((msg) {
      if (msg.notification != null) {
        final _notification = NotificationModel(
          title: msg.notification!.title!,
          text: msg.notification!.body!,
          gameMasterId: widget.userId,
          timestamp: Timestamp.now(),
        );
        _controller.addNotification(notificationModel: _notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (msg.notification != null) {
        final _notification = NotificationModel(
          title: msg.notification!.title!,
          text: msg.notification!.body!,
          gameMasterId: widget.userId,
          timestamp: Timestamp.now(),
        );
        _controller.addNotification(notificationModel: _notification);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _controller.noificationsSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoadingScreen(
              color: AppColors.appLight,
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Powiadomienia:",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appLight,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _removeNotifications(context),
                    ],
                  ),
                  Divider(
                    color: AppColors.appLight,
                    thickness: 0.6,
                  ),
                  Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }

                      if (snapshot.connectionState == ConnectionState.none) {
                        return SizedBox.shrink();
                      }

                      Map<dynamic, dynamic> data =
                          document.data()! as Map<dynamic, dynamic>;

                      if (widget.userId == data['gameMasterId']) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                '${data['title']} - ${data['text']}.',
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: AppColors.appLight,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.appLight,
                              thickness: 0.6,
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget _removeNotifications(
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.appDark,
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 3,
          spreadRadius: 0.5,
        ),
      ],
      borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
    ),
    child: TextButton(
      onPressed: () => eventEditHandle(context),
      child: Icon(
        CupertinoIcons.trash_circle,
        color: AppColors.appLight,
      ),
    ),
  );
}

void eventEditHandle(BuildContext context) {
  final _controller = NotificationsCotroller();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.appLight,
          title: Text(
            "Czy na pewno chcesz usunąć powiadomienia?",
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appDark,
                fontSize: 14.0,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controller.deleteNotifications();
                Navigator.pop(context);
                return;
              },
              child: Text(
                'Wyczyść',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appDark,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Wróć',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appDark,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
