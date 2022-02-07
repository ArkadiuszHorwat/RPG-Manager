import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/atributeCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterBio.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterImage.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/characterInfo.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/throwAgainstDeath.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharacterDetailsInfo extends StatefulWidget {
  CharacterDetailsInfo({
    required this.characterModel,
    required this.controller,
    required this.userId,
  });

  final CharacterModel characterModel;
  final String userId;
  final CharacterDetailsScreenController controller;

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
                    characterModel: widget.characterModel,
                    controller: widget.controller,
                    userId: widget.userId,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CharacterImage(
                    image: widget.characterModel.image,
                    characterId: widget.characterModel.characterId ?? '',
                    characterPD: widget.characterModel.characterPD ?? '',
                    characterLvl: widget.characterModel.characterLvl ?? 0,
                    characterUserId: widget.characterModel.userId ?? '',
                    userId: widget.userId,
                  ),
                ],
              ),
            ),
            CharacterBio(
              characterId: widget.characterModel.characterId ?? '',
              characterBio: widget.characterModel.characterBio ?? '',
              controller: widget.controller,
              characterUserId: widget.characterModel.userId ?? '',
              userId: widget.userId,
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
                    count: widget.characterModel.characterStrength ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj siłę',
                              hintText: 'Siła',
                              updateTargetName: 'strength',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                  AtributeCell(
                    atribute: 'ZR',
                    count: widget.characterModel.characterDexterity ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj zręczność',
                              hintText: 'Zręczność',
                              updateTargetName: 'dexterity',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                  AtributeCell(
                    atribute: 'K',
                    count: widget.characterModel.characterConstitution ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj Kondycję',
                              hintText: 'Kondycja',
                              updateTargetName: 'constitution',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                  AtributeCell(
                    atribute: 'INT',
                    count: widget.characterModel.characterIntelligence ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj inteligencje',
                              hintText: 'Inteligencja',
                              updateTargetName: 'intelligence',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                  AtributeCell(
                    atribute: 'M',
                    count: widget.characterModel.characterWisdom ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj mądrość',
                              hintText: 'Mądrość',
                              updateTargetName: 'wisdom',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                  AtributeCell(
                    atribute: 'CH',
                    count: widget.characterModel.characterCharisma ?? '',
                    action: widget.userId == widget.characterModel.userId
                        ? () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj charyzme',
                              hintText: 'Charyzma',
                              updateTargetName: 'charisma',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: 'number',
                              pathName: 'character',
                            )
                        : () {},
                  ),
                ],
              ),
            ),
            ThrowAgainstDeath(
              characterId: widget.characterModel.characterId ?? '',
              deathCheck: widget.characterModel.deathCheck ?? 0,
              lifeCheck: widget.characterModel.lifeCheck ?? 0,
              characterUserId: widget.characterModel.userId ?? '',
              userId: widget.userId,
            ),
          ],
        ),
      ),
    );
  }
}
