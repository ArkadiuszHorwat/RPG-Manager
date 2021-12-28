import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_description.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_image.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/widgets/campaign_players_list.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class CampaignDetailsScreen extends StatefulWidget {
  CampaignDetailsScreen({
    Key? key,
    required this.campaignId,
    required this.userId,
    required this.sessionType,
  });

  final String campaignId;
  final String userId;
  final String sessionType;

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  final _controller = CampaignDetailsScreenController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
          stream: _controller.getCampaignDetails(campaignId: widget.campaignId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.data != null) {
              Map<dynamic, dynamic> data =
                  snapshot.data!.data() as Map<dynamic, dynamic>;

              final _campaignModel = CampaignModel(
                title: data['title'],
                system: data['system'],
                campaignId: widget.campaignId,
                image: data['image'],
                sessionNumber: data['sessionNumber'] ?? 0,
                sessionStatus: data['sessionStatus'],
                activePlayers: data['activePlayers'],
              );

              return Scaffold(
                appBar: AppNavBar(
                  title: _campaignModel.title,
                  actions: [
                    widget.sessionType == 'game master'
                        ? IconButton(
                            onPressed: () {
                              _controller.campaignDelete(context,
                                  campaignId: widget.campaignId);
                            },
                            icon: Icon(Icons.delete_outline),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                backgroundColor: Colors.transparent,
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.black.withAlpha(50),
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
                      icon: Icon(Icons.person),
                      label: 'Gracze',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Notatki',
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CampaignImage(
                        campaignModel: _campaignModel,
                        controller: _controller,
                        sessionType: widget.sessionType,
                        userId: widget.userId,
                      ),
                      _currentIndex == 0
                          ? CampaignPlayersList(
                              controller: _controller,
                              charactersIds: _campaignModel.activePlayers ?? [],
                              userId: widget.userId,
                            )
                          : CampaignDescription(
                              campaignModel: _campaignModel,
                              controller: _controller,
                              userId: widget.userId,
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
