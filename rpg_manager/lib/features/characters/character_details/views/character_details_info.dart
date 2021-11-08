import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';

class CharacterDetailsInfo extends StatefulWidget {
  CharacterDetailsInfo({
    required this.image,
    required this.system,
  });

  final String image;
  final String system;

  @override
  State<CharacterDetailsInfo> createState() => _CharacterDetailsInfoState();
}

class _CharacterDetailsInfoState extends State<CharacterDetailsInfo> {
  var _deathCheck = 0;
  var _lifeCheck = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 350,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _characterInfo(widget.system),
                  SizedBox(
                    width: 10,
                  ),
                  _characterImage(widget.image, context),
                ],
              ),
            ),
            _characterBio(),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 110,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _characterAtributesCell('S', '17', '+3'),
                  _characterAtributesCell('ZR', '12', '+1'),
                  _characterAtributesCell('K', '16', '+3'),
                  _characterAtributesCell('INT', '7', '-2'),
                  _characterAtributesCell('M', '11', '0'),
                  _characterAtributesCell('CH', '10', '0'),
                ],
              ),
            ),
            _characterThrowsAgainstDeath(context),
            // Container(
            //   alignment: AlignmentDirectional.centerEnd,
            //   height: 150,
            //   width: double.infinity,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _characterInfoCell('Inspiracja', '1'),
            //       _characterInfoCell('Szybkość', '9'),
            //       _characterInfoCell('Inicjatywa', '+3'),
            //       _characterInfoCell('KP', '16'),
            //     ],
            //   ),
            // ),
            // Container(
            //   alignment: AlignmentDirectional.centerEnd,
            //   height: 150,
            //   width: double.infinity,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _characterInfoCell('PW (max)', '27'),
            //       _characterInfoCell('PW (temp)', '11'),
            //       _characterInfoCell('Inicjatywa', '+3'),
            //       _characterInfoCell('KW', 'k10'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _throwAgainstDeathChoose(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  'Znów uciekniesz śmierci?',
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => _deathCheck--);
                  if (_deathCheck == -3) {
                    setState(() => _deathCheck = 0);
                    setState(() => _lifeCheck = 0);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonNoText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _lifeCheck++);
                  if (_lifeCheck == 3) {
                    setState(() => _lifeCheck = 0);
                    setState(() => _deathCheck = 0);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonYesText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _characterThrowsAgainstDeath(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => _throwAgainstDeathChoose(context),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rzuty przeciw śmierci',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_outline_outlined,
                            color: _lifeCheck >= 1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.favorite_outline_outlined,
                            color: _lifeCheck >= 2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.favorite_outline_outlined,
                            color: _lifeCheck == 3
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            color: _deathCheck <= -1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.cancel_outlined,
                            color: _deathCheck <= -2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.cancel_outlined,
                            color: _deathCheck == -3
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _characterAtributesCell(
    String atribute,
    String count,
    String bonus,
  ) {
    return Container(
      width: 50,
      child: Column(
        children: [
          Text(
            atribute,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.none,
            height: 70,
            width: 65,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.appDark,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Text(
                    count,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appLight,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bonus,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _characterBio() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
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
            borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biografia',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec suscipit erat vel pretium mollis.'
                    'Donec nec neque non quam ultrices imperdiet ac vel arcu. Aenean magna justo, efficitur porta volutpat at,'
                    'consequat eu lorem. Vivamus mattis elementum urna, in ullamcorper urna eleifend eget. Praesent sagittis sagittis neque,'
                    'a egestas enim finibus non. Phasellus nisi leo, ullamcorper ut tempor vitae, mattis venenatis arcu. Nam eget justo sodales,'
                    'sollicitudin metus eu, suscipit odio. Morbi tempus faucibus augue, eget tristique leo porttitor vel. Vestibulum condimentum'
                    'velit vitae ipsum laoreet lobortis. Sed tempor felis quis interdum aliquam.'
                    'Integer metus felis, vestibulum ac cursus a, rutrum quis nisl. Nullam congue, massa a ultricies aliquet,'
                    'metus nunc tincidunt mauris, vel convallis sapien lacus quis diam.',
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
      ],
    );
  }

  Widget _characterInfoCell(
    String info,
    String count,
  ) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Text(
            info,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.none,
            height: 80,
            width: 65,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Center(
                child: Text(
              count,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: AppColors.appDark,
                  fontSize: 28.0,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _characterImage(String? image, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
              image: image == null || !File(image).existsSync()
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'lib/app_assets/images/character-img.jpg',
                      ),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(image)),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => _experiencePointsInfo(context),
              child: Container(
                clipBehavior: Clip.none,
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: AppColors.appLight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3,
                      spreadRadius: 0.5,
                    ),
                  ],
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(20)),
                ),
                child: Center(
                    child: Text(
                  '0',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 28.0,
                    ),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _characterInfo(String system) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            'Informacje o postaci:',
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: AppColors.appLight,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rasa',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      'Ork',
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
                    Text(
                      'Klasa',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      'Barbarzyńca',
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
                    Text(
                      'Charakter',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      'Neutralny zły',
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
                    Text(
                      'Aktualna przygoda',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      'Wrota Baldura',
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
                    Text(
                      'System',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      '$system',
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
        ],
      ),
    );
  }

  void _experiencePointsInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  'Punkty doświadczenia',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Text(
                  '1550',
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
          );
        });
  }
}
