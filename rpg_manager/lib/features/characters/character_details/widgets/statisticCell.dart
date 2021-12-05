import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class StatisticCell extends StatelessWidget {
  StatisticCell({
    required this.info,
    required this.value,
    required this.action,
  });

  final String info;
  final String value;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 100,
        child: Column(
          children: [
            Text(
              info,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              clipBehavior: Clip.none,
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.appLight,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    spreadRadius: 0.5,
                  ),
                ],
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              child: Center(
                  child: Text(
                value,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appDark,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
