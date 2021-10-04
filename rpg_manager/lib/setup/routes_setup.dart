import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/features/authorization/register/register.dart';
import 'package:rpg_manager/features/calendar/calendar.dart';
import 'package:rpg_manager/features/campaigns/campaigns.dart';
import 'package:rpg_manager/features/home/home.dart';
import 'package:rpg_manager/features/main_menu/main_menu.dart';
import 'package:rpg_manager/features/players_list/players_list.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class RoutesSetup {
  static Route<dynamic> routesSetup(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePageName.startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      case RoutePageName.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RoutePageName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutePageName.menu:
        return MaterialPageRoute(builder: (_) => MainMenu());
      case RoutePageName.calendarPage:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case RoutePageName.campaignsPage:
        return MaterialPageRoute(builder: (_) => CampaignsScreen());
      case RoutePageName.playersListPage:
        return MaterialPageRoute(builder: (_) => PlayersListScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppNavBar(
          title: 'Kraniec świata',
        ),
        body: AppBackground(
          child: Center(
            child: Text(
              'Tam gdzie diabeł mówi dobranoc',
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 247, 241, 227),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class RoutePageName {
  static const String register = '/register';
  static const String startPage = '/';
  static const String home = '/home';
  static const String menu = '/menu';
  static const String calendarPage = '/calendar';
  static const String campaignsPage = '/campaigns';
  static const String playersListPage = '/players';
}
