import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/home/home_controller.dart';
import 'package:rpg_manager/features/home/widgets/home_choice_item.dart';

class HomeChoice extends StatefulWidget {
  HomeChoice({
    Key? key,
    required this.data,
    required this.controller,
  }) : super(key: key);

  final User data;
  final HomeScreenController controller;

  @override
  _HomeChoiceState createState() => _HomeChoiceState();
}

class _HomeChoiceState extends State<HomeChoice> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeChoiceItem(
              title: AppLocal.homeGameMasterTitle,
              imagePath: 'lib/app_assets/images/mistrz-gry-img.jpg',
              actionRoute: () => widget.controller.onChoicePanelSelected(
                1,
                context,
                widget.data,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HomeChoiceItem(
              title: AppLocal.homePlayerTitle,
              imagePath: 'lib/app_assets/images/gracz-img.jpg',
              actionRoute: () => widget.controller.onChoicePanelSelected(
                2,
                context,
                widget.data,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
