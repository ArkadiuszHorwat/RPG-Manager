import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';

class AttacksAndMagicCell extends StatelessWidget {
  AttacksAndMagicCell({
    required this.controller,
    required this.characterId,
    this.multiTextValue,
  });

  final CharacterDetailsScreenController controller;
  final String characterId;
  final String? multiTextValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.atributeEditHandle(
        context,
        title: 'Edytuj swoje ataki oraz magię:',
        updateTargetName: 'attacksAndMagic',
        characterId: characterId,
        characterMultiText: multiTextValue,
        atributeType: 'text',
        pathName: 'character',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ataki i magia',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appDark,
                fontSize: 14.0,
              ),
            ),
          ),
          Divider(
            color: AppColors.appDark,
          ),
          Text(
            multiTextValue ?? '',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appDark,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: AppColors.appDark,
          ),
        ],
      ),
    );
  }
}
