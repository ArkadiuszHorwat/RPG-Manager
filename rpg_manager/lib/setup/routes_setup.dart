import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/features/authorization/register/register.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class RoutesSetup {
  static Route<dynamic> routesSetup(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => StartPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
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
