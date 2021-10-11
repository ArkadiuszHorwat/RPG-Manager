import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: Column(
              children: [
                _listItem('asd'),
                _listItem('asd'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _addCampaign() {
    return Container(
      color: Color.fromARGB(255, 247, 241, 227),
      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Dodaj kampanie',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 168, 128, 92),
                  ),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: Color.fromARGB(255, 168, 128, 92),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItem(String text) {
    return Column(
      children: [
        ListTile(
          tileColor: Color.fromARGB(150, 0, 0, 0),
          onTap: () {},
          title: Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 247, 241, 227),
              ),
            ),
          ),
          trailing: Icon(
            Icons.info_outline,
            color: Color.fromARGB(255, 247, 241, 227),
          ),
        ),
        Divider(
          color: Color.fromARGB(255, 247, 241, 227),
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
