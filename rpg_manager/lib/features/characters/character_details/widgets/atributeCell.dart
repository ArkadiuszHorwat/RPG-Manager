import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class AtributeCell extends StatelessWidget {
  AtributeCell({
    required this.atribute,
    required this.count,
    required this.bonus,
  });

  final String atribute;
  final String count;
  final String bonus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Column(
        children: [
          Text(
            atribute,
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
            width: 65,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.appDark,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Text(
                    count,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appLight,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bonus,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
