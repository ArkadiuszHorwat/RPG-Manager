import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';

class CharacterBio extends StatelessWidget {
  CharacterBio({
    required this.characterId,
    required this.characterBio,
    required this.controller,
  });

  final String characterId;
  final String characterBio;
  final CharacterDetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            controller.atributeEditHandle(
              context,
              title: 'Edytuj biografie',
              updateTargetName: 'bio',
              characterId: characterId,
              characterMultiText: characterBio,
              atributeType: 'string',
              pathName: 'character',
            );
          },
          child: Container(
            height: 200,
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
                    Text(
                      'Biografia',
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
                      characterBio,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
