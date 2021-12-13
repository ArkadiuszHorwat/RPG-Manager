import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list_item.dart';

class CampaignPlayersList extends StatelessWidget {
  CampaignPlayersList({
    Key? key,
    required this.controller,
  });

  final CampaignDetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: _infoContainer(),
    );
  }

  Widget _infoContainer() {
    var charactersList = <Widget>[];
    for (int i = 0; i <= 4; i++) {
      charactersList.add(CharacterListItem(
        characterName: 'name',
        image: 'image',
        action: () {},
      ));
    }
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
          CarouselSlider.builder(
            itemCount: charactersList.length,
            itemBuilder: (context, item, pageIndex) => Container(
              padding: EdgeInsetsDirectional.all(5),
              height: double.infinity,
              width: 180,
              child: CharacterListItem(
                characterName: 'name',
                image: 'image',
                action: () {},
              ),
            ),
            options: CarouselOptions(
              height: 280,
              autoPlay: false,
              viewportFraction: 0.4,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
  }
}
