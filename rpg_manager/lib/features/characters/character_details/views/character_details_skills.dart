import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/statisticCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

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
  CharacterDetailsSkills({
    required this.controller,
    required this.characterModel,
  });

  final CharacterDetailsScreenController controller;
  final CharacterModel characterModel;

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
                          StatisticCell(
                            info: 'Szybkość',
                            value: widget.characterModel.speed ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj szybkość:',
                              updateTargetName: 'speed',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'Inicjatywa',
                            value: widget.characterModel.initiative ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj inicjatywe:',
                              updateTargetName: 'initiative',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'Percepcja',
                            value: widget.characterModel.perception ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj percepcje:',
                              updateTargetName: 'perception',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatisticCell(
                            info: 'PW (max)',
                            value: widget.characterModel.maxPW ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj maksymalne punkty wytrzymałości:',
                              updateTargetName: 'maxPW',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'PW (temp)',
                            value: widget.characterModel.tempPW ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj aktualne punkty wytrzymałości:',
                              updateTargetName: 'tempPW',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'KP',
                            value: widget.characterModel.characterKP ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj klasę pancerza:',
                              updateTargetName: 'characterKP',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatisticCell(
                            info: 'Inspiracja',
                            value: widget.characterModel.inspiration ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj punkty inspiracji:',
                              updateTargetName: 'inspiration',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'Premia z biegłości',
                            value: widget.characterModel.specialBonus ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj premię z biegłości:',
                              updateTargetName: 'specialBonus',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "number",
                            ),
                          ),
                          StatisticCell(
                            info: 'KW',
                            value: widget.characterModel.characterKW ?? '',
                            action: () => widget.controller.atributeEditHandle(
                              context,
                              title: 'Edytuj kość wytrzymałości:',
                              updateTargetName: 'characterKW',
                              characterId:
                                  widget.characterModel.characterId ?? '',
                              atributeType: "text",
                            ),
                          ),
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
}
