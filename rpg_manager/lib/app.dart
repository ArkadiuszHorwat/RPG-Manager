import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:rpg_manager/features/home/home.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthentication>(
          create: (_) => FirebaseAuthentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthentication>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: AppLocal.titleApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
          platform: TargetPlatform.android,
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pl', 'PL'),
        ],
        initialRoute: RoutePageName.startPage,
        onGenerateRoute: RoutesSetup.routesSetup,
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
