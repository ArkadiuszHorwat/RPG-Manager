import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeChoice extends StatelessWidget {
  HomeChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print('MG');
              },
              child: Card(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      "lib/app_assets/images/mistrz-gry-img.jpg",
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'PANEL MISTRZA GRY',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 241, 227),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                print('gracz');
              },
              child: Card(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      "lib/app_assets/images/gracz-img.jpg",
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'PANEL GRACZA',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 241, 227),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
