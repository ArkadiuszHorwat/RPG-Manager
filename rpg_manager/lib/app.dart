import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';

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
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/app_assets/images/background-img.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: StartPage(),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocal.titleStartPage,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 247, 241, 227),
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.close_outlined,
              color: Color.fromARGB(255, 247, 241, 227),
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
