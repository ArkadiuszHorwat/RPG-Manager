import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/calendar/calendar_screen.dart';
import 'package:rpg_manager/features/campaigns/campaigns_screen.dart';
import 'package:rpg_manager/features/characters/characters_sreen.dart';
import 'package:rpg_manager/features/notifications/notifications_screen.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class MainMenu extends StatefulWidget {
  MainMenu({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final DocumentReference<Map<String, dynamic>> userData;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = widget.userData;
    return AppBackground(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: data.get(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            final _pages = <Widget>[
              CalendarScreen(
                sessionType: data['userSessionType'],
                userId: widget.userData.id,
              ),
              CampaignsScreen(
                sessionType: data['userSessionType'],
                userId: widget.userData.id,
              ),
              data['userSessionType'] == 'player'
                  ? CharactersScreen(
                      userId: widget.userData.id,
                    )
                  : NotificationsScreen(),
            ];

            return Scaffold(
              appBar: AppNavBar(),
              body: _pages[_currentIndex],
              backgroundColor: Colors.transparent,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                fixedColor: AppColors.appLight,
                unselectedItemColor: AppColors.appDark,
                elevation: 0.1,
                unselectedFontSize: 14,
                selectedFontSize: 16,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: AppLocal.mainMenuCalendarItemTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: AppLocal.mainMenuCampaignsItemTitle,
                  ),
                  data['userSessionType'] == 'player'
                      ? BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: AppLocal.mainMenuCharactersItemTitle,
                        )
                      : BottomNavigationBarItem(
                          icon: Icon(Icons.info_outline),
                          label: AppLocal.mainMenuNotificationsItemTitle,
                        ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
