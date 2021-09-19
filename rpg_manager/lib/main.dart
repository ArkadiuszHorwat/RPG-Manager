import 'package:flutter/material.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        // appBar: AppBar(
        //   title: Text('RPG MANAGER'),
        // ),
        body: LoginScreen(),
      ),
    );
  }
}
