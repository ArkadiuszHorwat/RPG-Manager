import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_equipment.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_info.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_skills.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_spells.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class CharacterDetailsScreen extends StatefulWidget {
  CharacterDetailsScreen({
    Key? key,
    required this.characterId,
  }) : super(key: key);

  final String characterId;

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  final _controller = CharacterDetailsScreenController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _characterDetails =
        _controller.getCharacterDetails(characterId: widget.characterId);

    return AppBackground(
      child: StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
          stream: _characterDetails,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map<dynamic, dynamic> data =
                  snapshot.data!.data() as Map<dynamic, dynamic>;

              final characterModel = CharacterModel(
                image: data['image'] ?? null,
                system: data['system'],
                characterId: widget.characterId,
                characterPD: data['characterPD'] ?? '0',
                activeCampaign: data['activeCampaign'],
                activeCampaignName: data['activeCampaignName'] ?? '',
                characterLvl: data['level'] ?? 0,
                lifeCheck: data['lifeCheck'] ?? 0,
                deathCheck: data['deathCheck'] ?? 0,
                characterBio: data['bio'],
                characterRace: data['race'],
                characterClass: data['class'],
                characterAlignment: data['alignment'],
                characterStrength: data['strength'],
                characterDexterity: data['dexterity'],
                characterConstitution: data['constitution'],
                characterIntelligence: data['intelligence'],
                characterWisdom: data['wisdom'],
                characterCharisma: data['charisma'],
                sM: data['SM'],
                sS: data['SS'],
                sE: data['SE'],
                sZ: data['SZ'],
                sP: data['SP'],
                attacksAndMagic: data['attacksAndMagic'],
                spellBaseAttribute: data['spellBaseAttribute'],
                countSpellCells: data['countSpellCells'],
                spellCellsUsed: data['spellCellsUsed'],
                throwAgainstSpells: data['throwAgainstSpells'],
                magicAttackBonus: data['magicAttackBonus'],
                speed: data['speed'],
                initiative: data['initiative'],
                perception: data['perception'],
                maxPW: data['maxPW'],
                tempPW: data['tempPW'],
                characterKP: data['characterKP'],
                inspiration: data['inspiration'],
                specialBonus: data['specialBonus'],
                characterKW: data['characterKW'],
                defenseThrowsCharisma: data['defenseThrowsCharisma'],
                defenseThrowsWisdom: data['defenseThrowsWisdom'],
                defenseThrowsIntelligence: data['defenseThrowsIntelligence'],
                defenseThrowsConstitution: data['defenseThrowsConstitution'],
                defenseThrowsDexterity: data['defenseThrowsDexterity'],
                defenseThrowsStrength: data['defenseThrowsStrength'],
                skillsId: data['skillsId'],
              );

              final _pages = <Widget>[
                CharacterDetailsInfo(
                  characterModel: characterModel,
                  controller: _controller,
                ),
                CharacterDetailsSkills(
                  characterModel: characterModel,
                  controller: _controller,
                ),
                CharacterDetailsEquipment(
                  characterModel: characterModel,
                  controller: _controller,
                ),
                CharacterDetailsSpells(
                  characterModel: characterModel,
                  controller: _controller,
                ),
              ];

              return Scaffold(
                appBar: AppNavBar(
                  title: '${data['name']}',
                  actions: [
                    IconButton(
                      onPressed: () {
                        _controller.characterDelete(context,
                            characterId: widget.characterId);
                      },
                      icon: Icon(Icons.person_off),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: _pages[_currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  fixedColor: AppColors.appLight,
                  unselectedItemColor: AppColors.appDark,
                  elevation: 0.1,
                  unselectedFontSize: 14,
                  selectedFontSize: 16,
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline_rounded),
                      label: 'Informacje',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.grade_outlined),
                      label: 'Umiejętności',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.backpack_outlined),
                      label: 'Ekwipunek',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book_outlined),
                      label: 'Czary',
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
    );
  }
}
