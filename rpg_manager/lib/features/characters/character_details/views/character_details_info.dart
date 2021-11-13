import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    required this.characterLvl,
    this.deathCheck,
    this.lifeCheck,
  });

  final String? image;
  final String system;
  final String characterId;
  final String? characterPD;
  final int characterLvl;
  final int? deathCheck;
  final int? lifeCheck;

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
            CharacterBio(),
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
                    count: '17',
                    bonus: '+3',
                  ),
                  AtributeCell(
                    atribute: 'ZR',
                    count: '12',
                    bonus: '+1',
                  ),
                  AtributeCell(
                    atribute: 'K',
                    count: '16',
                    bonus: '+3',
                  ),
                  AtributeCell(
                    atribute: 'INT',
                    count: '17',
                    bonus: '-2',
                  ),
                  AtributeCell(
                    atribute: 'M',
                    count: '7',
                    bonus: '0',
                  ),
                  AtributeCell(
                    atribute: 'CH',
                    count: '11',
                    bonus: '0',
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
}
