import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG MANAGER',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
