import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

final skills = [
  'Akrobatyka',
  'Atletyka',
  'Historia',
  'Intuicja',
  'Medycyna',
  'Opieka nad zwierzętami',
  'Oszustwo',
  'Percepcja',
  'Perswazja',
  'Przyroda',
  'Religia',
  'Skradanie się',
  'Sztuka przetrwania',
  'Śledztwo',
  'Wiedza tajemna',
  'Występy',
  'Zastraszenie',
  'Zwinne dłonie',
];

final savingThrows = [
  'Siła',
  'Zręczność',
  'Kondycja',
  'Inteligencja',
  'Mądrość',
  'Charyzma',
];

final atributes = [
  'Zrc',
  'Sil',
  'Int',
  'Mdr',
  'Cha',
];

class CharacterDetailsSkills extends StatefulWidget {
  @override
  State<CharacterDetailsSkills> createState() => _CharacterDetailsSkillsState();
}

class _CharacterDetailsSkillsState extends State<CharacterDetailsSkills> {
  var _pageFlag = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child: _pageFlag
                  ? TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _pageFlag = false;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppColors.appLight,
                      ),
                      label: Text(
                        'Reszta',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appLight,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _pageFlag = true;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.appLight,
                      ),
                      label: Text(
                        'Ogólne',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appLight,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            _pageFlag
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _infoContainer('Umiejętności', skills),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child:
                                _infoContainer('Rzuty obronne', savingThrows),
                          ),
                        ],
                      ),
                      _infoContainer('Zdolności', ['asda', 'asda', 'asd']),
                      _infoContainer(
                          'Biegłości i języki', ['asda', 'asda', 'asd']),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _characterInfoCell('Szybkość', '9'),
                          _characterInfoCell('Inicjatywa', '+3'),
                          _characterInfoCell('Percepcja', '14'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _characterInfoCell('PW (max)', '27'),
                          _characterInfoCell('PW (temp)', '11'),
                          _characterInfoCell('KP', '16'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _characterInfoCell('Inspiracja', '1'),
                          _characterInfoCell('Premia z biegłości', '+2'),
                          _characterInfoCell('KW', 'k10'),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _infoContainer(String title, List<String> items) {
    final listItem = <Widget>[];
    items.forEach((item) => listItem.add(_listElement(item)));
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 350,
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
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Column(
                    children: listItem,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listElement(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: AppColors.appDark,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          color: AppColors.appDark,
        ),
      ],
    );
  }

  Widget _characterInfoCell(
    String info,
    String count,
  ) {
    return Column(
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
          alignment: AlignmentDirectional.center,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.appLight,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
                spreadRadius: 0.5,
              ),
            ],
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
          ),
          child: Text(
            count,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: AppColors.appDark,
                fontSize: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
