import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/characters/characters_controller.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list_item.dart';

class CampaignPlayersList extends StatelessWidget {
  CampaignPlayersList({
    Key? key,
    required this.controller,
    required this.charactersIds,
    required this.userId,
  });

  final CampaignDetailsScreenController controller;
  final List<dynamic> charactersIds;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: _infoContainer(context),
    );
  }

  Widget _infoContainer(BuildContext context) {
    final _characterController = CharactersScreenController();

    return Container(
      height: 350,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktywni gracze',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.appLight,
                  thickness: 1,
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: controller.characters.snapshots(),
            builder: (context, snapshot) {
              var _activeCharactersList = <CharacterModel>[];
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.data != null) {
                snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                  Map<dynamic, dynamic> data =
                      document.data()! as Map<dynamic, dynamic>;
                  if (charactersIds.contains(document.id)) {
                    _activeCharactersList.add(CharacterModel(
                      name: data['name'],
                      image: data['image'],
                      characterId: document.id,
                    ));
                    return SizedBox.shrink();
                  } else
                    return SizedBox.shrink();
                }).toList();

                return CarouselSlider.builder(
                  itemCount: _activeCharactersList.length,
                  itemBuilder: (context, item, pageIndex) {
                    final _ids = {
                      'characterId':
                          _activeCharactersList.elementAt(item).characterId ??
                              '',
                      'userId': userId,
                    };
                    return Container(
                      padding: EdgeInsetsDirectional.all(5),
                      height: double.infinity,
                      width: 180,
                      child: CharacterListItem(
                        characterName:
                            _activeCharactersList.elementAt(item).name ?? '',
                        image:
                            _activeCharactersList.elementAt(item).image ?? '',
                        action: () =>
                            _characterController.routeToCharacterDetails(
                          context,
                          _ids,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 280,
                    autoPlay: false,
                    viewportFraction: 0.4,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
