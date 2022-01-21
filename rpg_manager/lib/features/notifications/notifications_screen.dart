import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

Map<String, String> notifiactionsMap = {
  'text': 'Akrobatyka została zaaktualizowana',
  'heroName': 'Tawroh',
};

final notificationsList = [
  notifiactionsMap,
  notifiactionsMap,
  notifiactionsMap,
  notifiactionsMap,
];

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
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
            ...notificationsList.map(
              (event) => Column(
                children: [
                  ListTile(
                    title: Text(
                      'U postaci ${event['heroName']} - ${event['text']}.',
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
              ),
            ),
          ],
        ),
      ),
    );
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
