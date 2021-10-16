import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterListItem extends StatelessWidget {
  CharacterListItem({
    required this.characterName,
  });

  final String characterName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: new AssetImage(
                'lib/app_assets/images/character-img.jpg',
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 168, 128, 92).withOpacity(0.8),
            ),
            child: Text(
              characterName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 247, 241, 227),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
