import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayersListItem extends StatelessWidget {
  PlayersListItem({
    required this.playerName,
  });

  final String playerName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
          alignment: AlignmentDirectional.centerStart,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
              image: new AssetImage(
                'lib/app_assets/images/gracz-img.jpg',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playerName,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 247, 241, 227),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(255, 247, 241, 227),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
