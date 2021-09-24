import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/authorization/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _fireTest = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG MANAGER',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   // appBar: AppBar(
      //   //   title: Text('RPG MANAGER'),
      //   // ),
      //   body: LoginScreen(),
      home: FutureBuilder(
        future: _fireTest,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong! ${snapshot.error.toString()}');
            return Center(
              child: Text('Something went wrong'),
            );
          } else if (snapshot.hasData) {
            print('success');
            return LoginScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
