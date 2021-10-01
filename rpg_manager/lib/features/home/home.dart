import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:rpg_manager/features/firebase/config.dart';
import 'package:rpg_manager/features/home/widgets/home_choice.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    final userName = FlutterFirebaseConfig.getFirestoreConnect()
        .collection('users')
        .doc(user!.uid)
        .get();

    return AppBackground(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: userName,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppNavBar(
                title: "Hello ${data['name']}",
                icon: IconButton(
                    icon: Icon(
                      Icons.door_back_outlined,
                    ),
                    onPressed: () {
                      _exitLogOutAlert(context);
                    }),
              ),
              body: HomeChoice(),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 247, 241, 227),
              color: Color.fromARGB(255, 168, 128, 92),
              value: 0.5,
              strokeWidth: 4.0,
            ),
          );
        },
      ),
    );
  }

  void _exitLogOutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 247, 241, 227),
            title: Text("Napewno chcesz się wylogować?"),
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
                onPressed: () {
                  context.read<FirebaseAuthentication>().signOut();
                  Navigator.pop(context);
                },
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
}
