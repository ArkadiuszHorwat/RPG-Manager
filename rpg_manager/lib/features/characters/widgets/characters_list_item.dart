import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/characters_controller.dart';

class CharacterListItem extends StatelessWidget {
  CharacterListItem({
    Key? key,
    required this.characterName,
    this.image,
    required this.controller,
    required this.characterId,
  });

  final String characterName;
  final String? image;
  final CharactersScreenController controller;
  final String characterId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.routeToCharacterDetails(context, characterId),
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
          image: image == null || !File(image!).existsSync()
              ? DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage(
                    'lib/app_assets/images/character-img.jpg',
                  ),
                )
              : DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: FileImage(File(image!)),
                ),
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(20),
              bottomEnd: Radius.circular(20),
            ),
            color: AppColors.appDark.withOpacity(0.8),
          ),
          child: Text(
            characterName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.appLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
