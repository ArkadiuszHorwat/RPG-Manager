import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class DefenseThrowsCell extends StatelessWidget {
  DefenseThrowsCell({
    required this.attribute,
    required this.action,
    required this.throwsCount,
  });

  final String attribute;
  final String throwsCount;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        clipBehavior: Clip.none,
        height: 70,
        width: 50,
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
                attribute,
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
                throwsCount,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appDark,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
