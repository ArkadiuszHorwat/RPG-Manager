import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsSkills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Umiejętności',
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: AppColors.appLight,
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.centerEnd,
          height: 150,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _characterInfoCell('Inspiracja', '1'),
              _characterInfoCell('Szybkość', '9'),
              _characterInfoCell('Inicjatywa', '+3'),
              _characterInfoCell('KP', '16'),
            ],
          ),
        ),
        Container(
          alignment: AlignmentDirectional.centerEnd,
          height: 150,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _characterInfoCell('PW (max)', '27'),
              _characterInfoCell('PW (temp)', '11'),
              _characterInfoCell('Inicjatywa', '+3'),
              _characterInfoCell('KW', 'k10'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _characterInfoCell(
    String info,
    String count,
  ) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Text(
            info,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.none,
            height: 70,
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
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Center(
                child: Text(
              count,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 24.0,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
