import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeChoiceItem extends StatelessWidget {
  const HomeChoiceItem({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.actionRoute,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final VoidCallback actionRoute;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: actionRoute,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            image: new AssetImage(
              imagePath,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 241, 227),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
