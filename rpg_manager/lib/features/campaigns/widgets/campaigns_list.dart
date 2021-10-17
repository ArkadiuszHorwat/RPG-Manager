import 'package:flutter/cupertino.dart';
import 'package:rpg_manager/features/campaigns/widgets/camaigns_card_item.dart';

class CampaignsList extends StatelessWidget {
  CampaignsList({
    required this.data,
  });

  final List<String> data;

  @override
  Widget build(BuildContext context) {
    final generalCampaignsList = <Widget>[];

    for (String campaign in data) {
      generalCampaignsList.add(CampaignsCardItem(
        title: campaign,
      ));
    }

    return Column(
      children: generalCampaignsList,
    );
  }
}
