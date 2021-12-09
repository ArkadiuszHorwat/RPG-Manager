import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';

class CampaignDescription extends StatelessWidget {
  CampaignDescription({
    required this.campaignModel,
    required this.userId,
    required this.controller,
  });

  final CampaignModel campaignModel;
  final CampaignDetailsScreenController controller;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
        stream: controller.getCampaignNotes(
            campaignId: campaignModel.campaignId ?? '', userId: userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Column(
              children: [
                Text(
                  'Brak notatek',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.appLight,
                ),
              ],
            );
          }

          if (snapshot.data != null) {
            Map<dynamic, dynamic> data =
                snapshot.data!.data() as Map<dynamic, dynamic>;
            final notes = data['notes'] ?? '';

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.descriptionEditHandle(
                        context,
                        title: 'Notatki',
                        updateTargetName: 'notes',
                        campaignId: campaignModel.campaignId,
                        userId: userId,
                        campaignMultiText: notes,
                      );
                    },
                    child: Container(
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
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notatki',
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: AppColors.appDark,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.appDark,
                              ),
                              Text(
                                notes,
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        });
  }
}
