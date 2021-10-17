import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/firebase/config.dart';
import 'package:rpg_manager/features/home/home_controller.dart';
import 'package:rpg_manager/features/home/widgets/home_choice.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final User userData;

  final _controller = HomeScreenController();

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
                title: "${data['name']}",
                icon: IconButton(
                    icon: Icon(
                      Icons.door_back_outlined,
                    ),
                    onPressed: () {
                      _controller.exitLogOutAlert(context);
                    }),
              ),
              body: HomeChoice(
                data: userData,
                controller: _controller,
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.appLight,
              color: AppColors.appDark,
              value: 0.5,
              strokeWidth: 4.0,
            ),
          );
        },
      ),
    );
  }
}
