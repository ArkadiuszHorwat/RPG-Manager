import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/defenseThrowsCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/statisticCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

final skills = [
  'Akrobatyka (Zrc)',
  'Atletyka (Sil)',
  'Historia (Int)',
  'Intuicja (Mdr)',
  'Medycyna (Mdr)',
  'Opieka nad zwierzętami (Mdr)',
  'Oszustwo (Cha)',
  'Percepcja (Mdr)',
  'Perswazja (Cha)',
  'Przyroda (Int)',
  'Religia (Int)',
  'Skradanie się (Zrc)',
  'Sztuka przetrwania (Mdr)',
  'Śledztwo (Int)',
  'Wiedza tajemna (Int)',
  'Występy (Cha)',
  'Zastraszenie (Cha)',
  'Zwinne dłonie (Zrc)',
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
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                        'Pozostałe',
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
                        'Wróć',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rzuty obronne:',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appLight,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        color: AppColors.appLight,
                      ),
                      _defenseThrows(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _infoContainer('Zdolności', [
                              'asda',
                              'asda',
                              'asd',
                              'asdasd',
                              'asdads asdsdsdasd sd asdas sdsdaas sdasdasd d sa sdss asdas'
                            ]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: _infoContainer(
                                'Biegłości i języki', ['asda', 'asda', 'asd']),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _infoContainer('Umiejętności', skills),
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
    return Container(
      height: 300,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                _addSkill(
                  context,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              height: 220,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: listItem,
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

  Widget _defenseThrows() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefenseThrowsCell(
            attribute: 'Sil',
            throwsCount: widget.characterModel.defenseThrowsStrength ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsStrength',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
          DefenseThrowsCell(
            attribute: 'Zrc',
            throwsCount: widget.characterModel.defenseThrowsDexterity ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsDexterity',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
          DefenseThrowsCell(
            attribute: 'Kon',
            throwsCount: widget.characterModel.defenseThrowsConstitution ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsConstitution',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
          DefenseThrowsCell(
            attribute: 'Int',
            throwsCount: widget.characterModel.defenseThrowsIntelligence ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsIntelligence',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
          DefenseThrowsCell(
            attribute: 'Mdr',
            throwsCount: widget.characterModel.defenseThrowsWisdom ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsWisdom',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
          DefenseThrowsCell(
            attribute: 'Cha',
            throwsCount: widget.characterModel.defenseThrowsCharisma ?? '',
            action: () => widget.controller.atributeEditHandle(
              context,
              title: 'Edytuj rzut obronny:',
              hintText: 'Rzut obronny',
              updateTargetName: 'defenseThrowsCharisma',
              characterId: widget.characterModel.characterId ?? '',
              atributeType: 'number',
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSkill(
    BuildContext context, {
    String? title,
  }) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      decoration: title != null
          ? BoxDecoration(
              color: AppColors.appDark,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
            )
          : BoxDecoration(),
      child: TextButton(
        onPressed: () => _onButtonPressed(
          context,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      title,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.appLight,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: title != null ? AppColors.appLight : AppColors.appDark,
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.appLight,
        builder: (context) {
          return _addSkillBuilder();
        });
  }

  Widget _addSkillBuilder() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              alignment: AlignmentDirectional.topCenter,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.appDark,
                  size: 44,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print('OK');

                        widget.controller.addItem(
                            name: _nameTextController.text,
                            timestamp: Timestamp.now(),
                            description: _descriptionTextController.text,
                            characterId:
                                widget.characterModel.characterId ?? "");

                        Navigator.pop(context);
                        setState(() {
                          _nameTextController.text = '';
                          _descriptionTextController.text = '';
                        });
                      } else {
                        print('błąd');
                      }
                    },
                    child: Text(
                      "Zatwierdź",
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nazwa przedmiotu:",
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _nameTextController,
                    decoration: InputDecoration(
                      hintText: "Nazwa przedmiotu",
                      hintStyle: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    autofocus: false,
                    validator: (text) {
                      if (text!.isEmpty) {
                        print('niefajen');
                        return '';
                      } else {
                        print('fajen');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Opis:",
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appDark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: TextFormField(
                          controller: _descriptionTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Opis",
                            hintStyle: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          autofocus: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
