import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsSkills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Umiejętności',
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
