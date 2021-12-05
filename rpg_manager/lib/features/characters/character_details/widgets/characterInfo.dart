import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharacterInfo extends StatelessWidget {
  CharacterInfo({
    required this.characterModel,
    required this.controller,
  });

  final CharacterModel characterModel;
  final CharacterDetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            'Informacje o postaci:',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoCell(
                      title: 'Rasa',
                      infoType: characterModel.characterRace ?? '',
                      action: () => controller.atributeEditHandle(
                        context,
                        title: 'Edytuj rase',
                        hintText: 'Rasa',
                        updateTargetName: 'race',
                        atributeType: 'string',
                        characterId: characterModel.characterId ?? '',
                        pathName: 'character',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Klasa',
                      infoType: characterModel.characterClass ?? '',
                      action: () => controller.atributeEditHandle(
                        context,
                        title: 'Edytuj klase',
                        hintText: 'Klasa',
                        updateTargetName: 'class',
                        atributeType: 'string',
                        characterId: characterModel.characterId ?? '',
                        pathName: 'character',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Charakter',
                      infoType: characterModel.characterAlignment ?? '',
                      action: () => controller.atributeEditHandle(
                        context,
                        title: 'Edytuj charakter',
                        hintText: 'Charakter',
                        updateTargetName: 'alignment',
                        atributeType: 'string',
                        characterId: characterModel.characterId ?? '',
                        pathName: 'character',
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'Aktualna przygoda',
                      infoType: characterModel.characterActiveCampaign ?? '',
                      action: () {},
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    _infoCell(
                      title: 'System',
                      infoType: characterModel.system ?? '',
                      action: () {},
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCell({
    required String title,
    required VoidCallback action,
    required String infoType,
  }) {
    return GestureDetector(
      onTap: action,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 14.0,
                ),
              ),
            ),
            Text(
              infoType,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
