import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/atributeCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterBio.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterImage.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterInfo.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/throwAgainstDeath.dart';

class CharacterDetailsInfo extends StatefulWidget {
  CharacterDetailsInfo({
    this.image,
    required this.system,
    required this.characterId,
    this.characterPD,
    this.characterActiveCampaign,
    required this.characterLvl,
    this.deathCheck,
    this.lifeCheck,
    this.characterBio,
    this.characterRace,
    this.characterClass,
    this.characterAlignment,
    this.characterCharisma,
    this.characterStrength,
    this.characterDexterity,
    this.characterConstitution,
    this.characterIntelligence,
    this.characterWisdom,
  });

  final String? image;
  final String system;
  final String characterId;
  final String? characterPD;
  final String? characterActiveCampaign;
  final int characterLvl;
  final int? deathCheck;
  final int? lifeCheck;
  final String? characterBio;
  final String? characterRace;
  final String? characterClass;
  final String? characterAlignment;
  final String? characterCharisma;
  final String? characterStrength;
  final String? characterDexterity;
  final String? characterConstitution;
  final String? characterIntelligence;
  final String? characterWisdom;

  @override
  State<CharacterDetailsInfo> createState() => _CharacterDetailsInfoState();
}

class _CharacterDetailsInfoState extends State<CharacterDetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 350,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterInfo(
                    system: widget.system,
                    characterId: widget.characterId,
                    characterRace: widget.characterRace ?? '',
                    characterClass: widget.characterClass ?? '',
                    characterAlignment: widget.characterAlignment ?? '',
                    characterActiveCampaign:
                        widget.characterActiveCampaign ?? '',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CharacterImage(
                    image: widget.image,
                    characterId: widget.characterId,
                    characterPD: widget.characterPD,
                    characterLvl: widget.characterLvl,
                  ),
                ],
              ),
            ),
            CharacterBio(
              characterId: widget.characterId,
              characterBio: widget.characterBio ?? '',
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 110,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AtributeCell(
                    atribute: 'S',
                    count: widget.characterStrength ?? '',
                    action: () => _atributeEditHandle(
                      context,
                      title: 'Edytuj siłę',
                      hintText: 'Siła',
                      updateTargetName: 'strength',
                    ),
                  ),
                  AtributeCell(
                    atribute: 'ZR',
                    count: widget.characterDexterity ?? '',
                    action: () => _atributeEditHandle(
                      context,
                      title: 'Edytuj zręczność',
                      hintText: 'Zręczność',
                      updateTargetName: 'dexterity',
                    ),
                  ),
                  AtributeCell(
                    atribute: 'K',
                    count: widget.characterConstitution ?? '',
                    action: () => _atributeEditHandle(
                      context,
                      title: 'Edytuj Kondycję',
                      hintText: 'Kondycja',
                      updateTargetName: 'constitution',
                    ),
                  ),
                  AtributeCell(
                    atribute: 'INT',
                    count: widget.characterIntelligence ?? '',
                    action: () => _atributeEditHandle(
                      context,
                      title: 'Edytuj inteligencje',
                      hintText: 'Inteligencja',
                      updateTargetName: 'intelligence',
                    ),
                  ),
                  AtributeCell(
                    atribute: 'M',
                    count: widget.characterWisdom ?? '',
                    action: () => _atributeEditHandle(
                      context,
                      title: 'Edytuj mądrość',
                      hintText: 'Mądrość',
                      updateTargetName: 'wisdom',
                    ),
                  ),
                  AtributeCell(
                    atribute: 'CH',
                    count: widget.characterCharisma ?? '',
                    action: () => _atributeEditHandle(context,
                        title: 'Edytuj charyzme',
                        hintText: 'Charyzma',
                        updateTargetName: 'charisma'),
                  ),
                ],
              ),
            ),
            ThrowAgainstDeath(
              characterId: widget.characterId,
              deathCheck: widget.deathCheck ?? 0,
              lifeCheck: widget.lifeCheck ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  void _atributeEditHandle(
    BuildContext context, {
    required String title,
    required String hintText,
    required String updateTargetName,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();
          final formKey = GlobalKey<FormState>();
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  title,
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
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    autofocus: false,
                    validator: (text) {
                      if (text != null) {
                        print('fajen');
                      } else {
                        print('niefajen');
                        return '';
                      }
                    },
                  ),
                ),
                Divider(
                  color: AppColors.appDark,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  try {
                    CollectionReference characters =
                        FirebaseFirestore.instance.collection('characters');

                    characters
                        .doc('${widget.characterId}')
                        .update({updateTargetName: textController.text})
                        .then((value) => print('$updateTargetName was updated'))
                        .catchError((error) =>
                            print('Failed to update $updateTargetName'));
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Zapisz',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Wróć',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
