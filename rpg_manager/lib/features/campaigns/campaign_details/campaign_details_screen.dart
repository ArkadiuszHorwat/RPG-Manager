import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_image.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final _controller = CampaignDetailsScreenController();

  CampaignDetailsScreen({
    Key? key,
    required this.campaignId,
  });

  final String campaignId;

  @override
  Widget build(BuildContext context) {
    final _campaignDetails =
        _controller.getCampaignDetails(campaignId: campaignId);
    return AppBackground(
      child: StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
          stream: _campaignDetails,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map<dynamic, dynamic> data =
                  snapshot.data!.data() as Map<dynamic, dynamic>;

              final _campaignModel = CampaignModel(
                title: data['title'],
                system: data['system'],
                image: data['image'],
                sessionNumber: data['sessionNumber'],
              );

              return Scaffold(
                appBar: AppNavBar(
                  title: _campaignModel.title,
                  actions: [
                    IconButton(
                      onPressed: () {
                        _controller.campaignDelete(context,
                            campaignId: campaignId);
                      },
                      icon: Icon(Icons.delete_outline),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CampaignImage(
                        image: _campaignModel.image,
                        campaignId: campaignId,
                        sessionNumber: _campaignModel.sessionNumber ?? 0,
                        system: _campaignModel.system,
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
