import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsSpells extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Czary',
        style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: AppColors.appLight,
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }
}
