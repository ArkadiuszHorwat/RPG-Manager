import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterDetailsEquipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ekwipunek',
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
