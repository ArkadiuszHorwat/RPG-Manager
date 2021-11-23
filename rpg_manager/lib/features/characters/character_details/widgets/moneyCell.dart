import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class MoneyCell extends StatelessWidget {
  MoneyCell({
    required this.title,
    required this.action,
    this.value,
  });

  final String title;
  final VoidCallback action;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 50,
        width: 80,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appLight,
                    fontSize: 11.0,
                  ),
                ),
              ),
              value != null
                  ? Text(
                      value!,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appLight,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
