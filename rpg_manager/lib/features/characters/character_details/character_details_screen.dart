import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_equipment.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_info.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_skills.dart';
import 'package:rpg_manager/features/characters/character_details/views/character_details_spells.dart';
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
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _characterDetails,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              final String? image = data['image'];

              final _pages = <Widget>[
                CharacterDetailsInfo(
                  image: image ?? null,
                  system: data['system'],
                  characterId: widget.characterId,
                  characterPD: data['characterPD'] ?? '0',
                  characterLvl: data['level'] ?? 0,
                  lifeCheck: data['lifeCheck'] ?? 0,
                  deathCheck: data['deathCheck'] ?? 0,
                  characterBio: data['bio'],
                  characterRace: data['race'],
                  characterClass: data['class'],
                  characterAlignment: data['alignment'],
                ),
                CharacterDetailsSkills(),
                CharacterDetailsEquipment(),
                CharacterDetailsSpells(),
              ];

              return Scaffold(
                appBar: AppNavBar(
                  title: '${data['name']}',
                  actions: [
                    IconButton(
                      onPressed: () {
                        _characterDelete(context);
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

  void _characterDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  'Napewno chcesz usunąć postać?',
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  try {
                    Navigator.pop(context);
                    Navigator.pop(context);

                    CollectionReference characters =
                        FirebaseFirestore.instance.collection('characters');

                    characters
                        .doc('${widget.characterId}')
                        .delete()
                        .then((value) => print('character was deleted'))
                        .catchError(
                            (error) => print('Failed to delete character'));
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                },
                child: Text(
                  'Tak',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Nie',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
