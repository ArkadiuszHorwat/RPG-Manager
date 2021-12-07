import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';

class CampaignDescription extends StatelessWidget {
  CampaignDescription({
    required this.campaignModel,
    required this.controller,
  });

  final CampaignModel campaignModel;
  final CampaignDetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            controller.descriptionEditHandle(
              context,
              title: 'Notatki',
              updateTargetName: 'description',
              campaignId: campaignModel.campaignId,
              campaignMultiText: campaignModel.description,
            );
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
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
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.appDark,
                    ),
                    Text(
                      campaignModel.description ?? '',
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
    );
  }
}
