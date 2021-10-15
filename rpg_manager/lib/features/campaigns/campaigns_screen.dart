import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/features/campaigns/widgets/campaigns_list.dart';

final testCampaignsList = [
  'Zapomniana kopalnia Phandelvera',
  'Język smoka',
  'Wrota Baldura',
  'Wrota Baldura',
  'Wrota Baldura',
  'Wrota Baldura',
  'Wrota Baldura',
];

class CampaignsScreen extends StatefulWidget {
  @override
  _CampaignsScreenState createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addCampaign(),
        Expanded(
          child: SingleChildScrollView(
            child: CampaignsList(data: testCampaignsList),
          ),
        ),
      ],
    );
  }

  Widget _addCampaign() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Dodaj kampanie',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 247, 241, 227),
                  ),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: Color.fromARGB(255, 247, 241, 227),
            ),
          ],
        ),
      ),
    );
  }
}
