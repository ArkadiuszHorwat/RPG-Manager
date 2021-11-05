import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/register/register_screen.dart';
import 'package:rpg_manager/features/calendar/calendar_screen.dart';
import 'package:rpg_manager/features/campaigns/campaigns_screen.dart';
import 'package:rpg_manager/features/characters/characters_sreen.dart';
import 'package:rpg_manager/features/home/home_screen.dart';
import 'package:rpg_manager/features/main_menu/main_menu_screen.dart';
import 'package:rpg_manager/features/players/players_screen.dart';
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
        return MaterialPageRoute(builder: (_) {
          args as HomeScreen;
          return HomeScreen(
            userData: args.userData,
          );
        });
      case RoutePageName.menu:
        return MaterialPageRoute(builder: (_) {
          args as DocumentReference<Map<String, dynamic>>;
          return MainMenu(
            userData: args,
          );
        });
      case RoutePageName.calendarPage:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case RoutePageName.campaignsPage:
        return MaterialPageRoute(builder: (_) {
          args as String;
          return CampaignsScreen(
            sessionType: args,
            userId: args,
          );
        });
      case RoutePageName.playersListPage:
        return MaterialPageRoute(builder: (_) => PlayersScreen());
      case RoutePageName.charactersListPage:
        return MaterialPageRoute(builder: (_) {
          args as String;
          return CharactersScreen(
            userId: args,
          );
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppNavBar(
          title: AppLocal.errorRouteTitle,
        ),
        body: AppBackground(
          child: Center(
            child: Text(
              AppLocal.errorRouteText,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: 28,
                  color: AppColors.appLight,
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
  static const String playersListPage = '/playersList';
  static const String charactersListPage = '/charactersList';
}
