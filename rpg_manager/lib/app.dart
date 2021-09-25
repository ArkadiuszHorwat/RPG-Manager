import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';
import 'package:rpg_manager/setup/routes_setup.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocal.titleApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey,
        platform: TargetPlatform.android,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pl', 'PL'),
      ],
      initialRoute: '/',
      onGenerateRoute: RoutesSetup.routesSetup,
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppNavBar(
        title: AppLocal.titleStartPage,
        icon: IconButton(
            icon: Icon(
              Icons.close_outlined,
            ),
            onPressed: () {
              exitAlert(context);
            }),
      ),
      body: LoginScreen(),
    );
  }
}

void exitAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 247, 241, 227),
          title: Text("Napewno chcesz wyjść?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Nie',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: Text(
                'Tak',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      });
}
