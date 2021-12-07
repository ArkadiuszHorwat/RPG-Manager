import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_description.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_image.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

//TODO: create flag to activePlayers widget or descriptions widget + create update methods to them
class CampaignDetailsScreen extends StatelessWidget {
  final _controller = CampaignDetailsScreenController();

  CampaignDetailsScreen({
    Key? key,
    required this.campaignId,
    required this.sessionType,
  });

  final String campaignId;
  final String sessionType;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
          stream: _controller.getCampaignDetails(campaignId: campaignId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (snapshot.data != null) {
              Map<dynamic, dynamic> data =
                  snapshot.data!.data() as Map<dynamic, dynamic>;

              final _campaignModel = CampaignModel(
                title: data['title'],
                system: data['system'],
                campaignId: campaignId,
                image: data['image'],
                sessionNumber: data['sessionNumber'] ?? 0,
                sessionStatus: data['sessionStatus'],
                description: data['description'] ?? '',
              );

              return Scaffold(
                appBar: AppNavBar(
                  title: _campaignModel.title,
                  actions: [
                    sessionType == 'game master'
                        ? IconButton(
                            onPressed: () {
                              _controller.campaignDelete(context,
                                  campaignId: campaignId);
                            },
                            icon: Icon(Icons.delete_outline),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CampaignImage(
                        campaignModel: _campaignModel,
                        controller: _controller,
                        sessionType: sessionType,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Aktywni gracze",
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: AppColors.appLight,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Notatki",
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: AppColors.appLight,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CampaignDescription(
                        campaignModel: _campaignModel,
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
    );
  }
}
