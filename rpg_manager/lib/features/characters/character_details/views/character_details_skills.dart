import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/defenseThrowsCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/statisticCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';
import 'package:rpg_manager/features/characters/models/skills_model.dart';
import 'package:rpg_manager/widgets/app_loading_screen.dart';

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
                      Divider(
                        color: AppColors.appLight,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _infoContainer(
                              title: 'Zdolności',
                              collectionName: 'features',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: _infoContainer(
                              title: 'Biegłości i języki',
                              collectionName: 'proficiencies',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _infoContainer(
                        title: 'Umiejętności',
                        collectionName: 'skills',
                        items: SkillsModel().skills,
                      ),
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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
                              pathName: 'character',
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

  Widget _infoContainer({
    required String title,
    required String collectionName,
    List<String>? items,
  }) {
    Stream<QuerySnapshot<Object?>>? _currentSnapshot;

    switch (collectionName) {
      case 'proficiencies':
        _currentSnapshot = widget.controller.proficienciesSnapshot;
        break;
      case 'features':
        _currentSnapshot = widget.controller.featuresSnapshot;
        break;
      default:
    }
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                items != null
                    ? SizedBox.shrink()
                    : _addSkill(
                        context,
                        collectionName: collectionName,
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              height: 250,
              child: SingleChildScrollView(
                child: items != null
                    ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: widget.controller.getSkills(
                            skillsId: widget.characterModel.skillsId ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.data != null) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            final skillsModel = SkillsModel(
                              acrobatics: data['acrobatics'],
                              animalHandling: data['animalHandling'],
                              arcana: data['arcana'],
                              athletics: data['athletics'],
                              deception: data['deception'],
                              history: data['history'],
                              insight: data['insight'],
                              intimidation: data['intimidation'],
                              investigation: data['investigation'],
                              medicine: data['medicine'],
                              nature: data['nature'],
                              perception: data['perception'],
                              performance: data['performance'],
                              persuasion: data['persuasion'],
                              religion: data['religion'],
                              sleightOfHand: data['sleightOfHand'],
                              stealth: data['stealth'],
                              survival: data['survival'],
                            );

                            final listItem = <Widget>[];

                            items.forEach((item) {
                              var _itemValue = '';
                              var _updateTargetName = '';
                              switch (item) {
                                case 'Akrobatyka (Zrc)':
                                  _itemValue = skillsModel.acrobatics ?? '';
                                  _updateTargetName = 'acrobatics';
                                  break;
                                case 'Atletyka (Sil)':
                                  _itemValue = skillsModel.athletics ?? '';
                                  _updateTargetName = 'athletics';
                                  break;
                                case 'Historia (Int)':
                                  _itemValue = skillsModel.history ?? '';
                                  _updateTargetName = 'history';
                                  break;
                                case 'Intuicja (Mdr)':
                                  _itemValue = skillsModel.insight ?? '';
                                  _updateTargetName = 'insight';
                                  break;
                                case 'Medycyna (Mdr)':
                                  _itemValue = skillsModel.medicine ?? '';
                                  _updateTargetName = 'medicine';
                                  break;
                                case 'Opieka nad zwierzętami (Mdr)':
                                  _itemValue = skillsModel.animalHandling ?? '';
                                  _updateTargetName = 'animalHandling';
                                  break;
                                case 'Oszustwo (Cha)':
                                  _itemValue = skillsModel.deception ?? '';
                                  _updateTargetName = 'deception';
                                  break;
                                case 'Percepcja (Mdr)':
                                  _itemValue = skillsModel.perception ?? '';
                                  _updateTargetName = 'perception';
                                  break;
                                case 'Perswazja (Cha)':
                                  _itemValue = skillsModel.persuasion ?? '';
                                  _updateTargetName = 'persuasion';
                                  break;
                                case 'Przyroda (Int)':
                                  _itemValue = skillsModel.nature ?? '';
                                  _updateTargetName = 'nature';
                                  break;
                                case 'Religia (Int)':
                                  _itemValue = skillsModel.religion ?? '';
                                  _updateTargetName = 'religion';
                                  break;
                                case 'Skradanie się (Zrc)':
                                  _itemValue = skillsModel.stealth ?? '';
                                  _updateTargetName = 'stealth';
                                  break;
                                case 'Sztuka przetrwania (Mdr)':
                                  _itemValue = skillsModel.survival ?? '';
                                  _updateTargetName = 'survival';
                                  break;
                                case 'Śledztwo (Int)':
                                  _itemValue = skillsModel.investigation ?? '';
                                  _updateTargetName = 'investigation';
                                  break;
                                case 'Wiedza tajemna (Int)':
                                  _itemValue = skillsModel.arcana ?? '';
                                  _updateTargetName = 'arcana';
                                  break;
                                case 'Występy (Cha)':
                                  _itemValue = skillsModel.performance ?? '';
                                  _updateTargetName = 'performance';
                                  break;
                                case 'Zastraszenie (Cha)':
                                  _itemValue = skillsModel.intimidation ?? '';
                                  _updateTargetName = 'intimidation';
                                  break;
                                case 'Zwinne dłonie (Zrc)':
                                  _itemValue = skillsModel.sleightOfHand ?? '';
                                  _updateTargetName = 'sleightOfHand';
                                  break;
                                default:
                              }
                              listItem.add(_listElement(
                                name: item,
                                elementId: '',
                                collectionName: 'skills',
                                context: context,
                                value: _itemValue,
                                updateTargetName: _updateTargetName,
                              ));
                            });

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listItem,
                            );
                          }
                          return SizedBox.shrink();
                        })
                    : StreamBuilder<QuerySnapshot>(
                        stream: _currentSnapshot,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.data != null) {
                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<dynamic, dynamic> data =
                                      document.data()! as Map<dynamic, dynamic>;

                                  if (data["characterId"] ==
                                      widget.characterModel.characterId) {
                                    return _listElement(
                                      name: data['name'],
                                      context: context,
                                      description: data["description"],
                                      elementId: document.id,
                                      collectionName: collectionName,
                                    );
                                  } else
                                    return SizedBox.shrink();
                                }).toList(),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listElement({
    required String name,
    required String elementId,
    required String collectionName,
    String? description,
    required BuildContext context,
    String? value,
    String? updateTargetName,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: collectionName == 'skills'
          ? () => widget.controller.atributeEditHandle(
                context,
                title: 'Edytuj umiejętność',
                updateTargetName: updateTargetName ?? '',
                skillId: widget.characterModel.skillsId,
                atributeType: 'number',
                pathName: 'skills',
              )
          : () => _itemInfoEditHandle(
                context: context,
                name: name,
                description: description ?? "",
              ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              collectionName == 'skills'
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            value ?? '',
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: AppColors.appDark,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: AppColors.appDark,
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        widget.controller.delete(context,
                            id: elementId,
                            collectionName: collectionName,
                            title: 'Czy na pewno chcesz to usunąć?');
                      },
                      icon: Icon(Icons.cancel_outlined),
                      color: AppColors.appDark,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
            ],
          ),
          Divider(
            color: AppColors.appDark,
          ),
        ],
      ),
    );
  }

  void _itemInfoEditHandle({
    required BuildContext context,
    required String name,
    required String description,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Text(
                  name,
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
                  description,
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
                  Navigator.pop(context);
                },
                child: Text(
                  'Wróć',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
              pathName: 'character',
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
              pathName: 'character',
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
              pathName: 'character',
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
              pathName: 'character',
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
              pathName: 'character',
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
              pathName: 'character',
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSkill(
    BuildContext context, {
    String? title,
    required String collectionName,
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
          collectionName: collectionName,
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

  void _onButtonPressed(BuildContext context,
      {required String collectionName}) {
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
          return _addSkillBuilder(collectionName: collectionName);
        });
  }

  Widget _addSkillBuilder({required String collectionName}) {
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
                          characterId: widget.characterModel.characterId ?? "",
                          pathName: collectionName,
                        );

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
                    "Nazwa:",
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
                      hintText: "Nazwa",
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
