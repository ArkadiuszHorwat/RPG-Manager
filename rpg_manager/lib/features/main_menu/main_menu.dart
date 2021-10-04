import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/calendar/calendar.dart';
import 'package:rpg_manager/features/campaigns/campaigns.dart';
import 'package:rpg_manager/features/players_list/players_list.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;
  final _pages = <Widget>[
    CalendarScreen(),
    CampaignsScreen(),
    PlayersListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppNavBar(title: ''),
        body: _pages[_currentIndex],
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          fixedColor: Color.fromARGB(255, 247, 241, 227),
          unselectedItemColor: Color.fromARGB(255, 168, 128, 92),
          elevation: 0.1,
          unselectedFontSize: 14,
          selectedFontSize: 16,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Kalendarz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Kampanie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Gracze',
            ),
          ],
        ),
      ),
    );
  }
}
