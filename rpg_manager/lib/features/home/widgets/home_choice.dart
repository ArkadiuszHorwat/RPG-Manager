import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/home/widgets/home_choice_item.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class HomeChoice extends StatelessWidget {
  HomeChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeChoiceItem(
              title: 'PANEL MISTRZA GRY',
              imagePath: 'lib/app_assets/images/mistrz-gry-img.jpg',
              actionRoute: () =>
                  Navigator.of(context).pushNamed(RoutePageName.menu),
            ),
            SizedBox(
              height: 10,
            ),
            HomeChoiceItem(
              title: 'PANEL GRACZA',
              imagePath: 'lib/app_assets/images/gracz-img.jpg',
              actionRoute: () => print('GRACZ'),
            ),
          ],
        ),
      ),
    );
  }
}
