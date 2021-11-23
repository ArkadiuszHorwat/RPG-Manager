import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/attacksAndMagicCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/moneyCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharacterDetailsEquipment extends StatelessWidget {
  CharacterDetailsEquipment({
    required this.characterModel,
    required this.controller,
  });

  final CharacterModel characterModel;
  final CharacterDetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _inventory(context),
            _equipment(context),
          ],
        ),
      ),
    );
  }

  Widget _equipment(BuildContext context) {
    final _equipElements = <Widget>[];
    for (int i = 0; i <= 5; i++) {
      _equipElements.add(_inventoryElement());
    }
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 350,
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
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ekwipunek',
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Column(
                          children: _equipElements,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MoneyCell(
                        title: 'SM',
                        action: () => controller.atributeEditHandle(
                          context,
                          title: 'Sztuki miedzi',
                          updateTargetName: 'SM',
                          characterId: characterModel.characterId ?? '',
                          atributeType: 'number',
                        ),
                        value: characterModel.sM,
                      ),
                      MoneyCell(
                        title: 'SS',
                        action: () => controller.atributeEditHandle(
                          context,
                          title: 'Sztuki srebra',
                          updateTargetName: 'SS',
                          characterId: characterModel.characterId ?? '',
                          atributeType: 'number',
                        ),
                        value: characterModel.sS,
                      ),
                      MoneyCell(
                        title: 'SE',
                        action: () => controller.atributeEditHandle(
                          context,
                          title: 'Sztuki eledium',
                          updateTargetName: 'SE',
                          characterId: characterModel.characterId ?? '',
                          atributeType: 'number',
                        ),
                        value: characterModel.sE,
                      ),
                      MoneyCell(
                        title: 'SZ',
                        action: () => controller.atributeEditHandle(
                          context,
                          title: 'Sztuki złota',
                          updateTargetName: 'SZ',
                          characterId: characterModel.characterId ?? '',
                          atributeType: 'number',
                        ),
                        value: characterModel.sZ,
                      ),
                      MoneyCell(
                        title: 'SP',
                        action: () => controller.atributeEditHandle(
                          context,
                          title: 'Sztuki platyny',
                          updateTargetName: 'SP',
                          characterId: characterModel.characterId ?? '',
                          atributeType: 'number',
                        ),
                        value: characterModel.sP,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inventory(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 400,
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
                    'Wyposażenie',
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
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'nazwa',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'premia do ataku',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'obrażenia/typ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _equipElement('miecz długi', '+2', '1k8/sieczne'),
                  SizedBox(
                    height: 5,
                  ),
                  _equipElement('miecz krótki', '+1', '1k6+1/kłute'),
                  SizedBox(
                    height: 5,
                  ),
                  _equipElement('długi łuk', '+3', '1k10/kłute'),
                  SizedBox(
                    height: 10,
                  ),
                  AttacksAndMagicCell(
                    controller: controller,
                    characterId: characterModel.characterId ?? '',
                    multiTextValue: characterModel.attacksAndMagic,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inventoryElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'element ekwipunku',
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
    );
  }

  Widget _equipElement(String name, String bonus, String type) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: AppColors.appDark,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            height: 40,
            child: Text(
              name,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: AppColors.appDark,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            height: 40,
            child: Text(
              bonus,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: AppColors.appDark,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            height: 40,
            child: Text(
              type,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
