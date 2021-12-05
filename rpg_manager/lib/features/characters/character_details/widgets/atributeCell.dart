import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class AtributeCell extends StatelessWidget {
  AtributeCell({
    required this.atribute,
    required this.count,
    required this.action,
  });

  final String atribute;
  final String count;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    var bonus = '';

    switch (count) {
      case '1':
        bonus = '-5';
        break;
      case '2':
      case '3':
        bonus = '-4';
        break;
      case '4':
      case '5':
        bonus = '-3';
        break;
      case '6':
      case '7':
        bonus = '-2';
        break;
      case '8':
      case '9':
        bonus = '-1';
        break;
      case '10':
      case '11':
        bonus = '0';
        break;
      case '12':
      case '13':
        bonus = '+1';
        break;
      case '14':
      case '15':
        bonus = '+2';
        break;
      case '16':
      case '17':
        bonus = '+3';
        break;
      case '18':
      case '19':
        bonus = '+4';
        break;
      case '20':
      case '21':
        bonus = '+5';
        break;
      default:
    }

    return GestureDetector(
      onTap: action,
      child: Container(
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
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
