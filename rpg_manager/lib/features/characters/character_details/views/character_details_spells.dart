import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/statisticCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharacterDetailsSpells extends StatefulWidget {
  CharacterDetailsSpells({
    required this.controller,
    required this.characterModel,
    required this.userId,
  });

  final CharacterDetailsScreenController controller;
  final CharacterModel characterModel;
  final String userId;

  @override
  State<CharacterDetailsSpells> createState() => _CharacterDetailsSpellsState();
}

class _CharacterDetailsSpellsState extends State<CharacterDetailsSpells> {
  final _spellsLvl = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var spellsLvl = '0';
  var _level = '0';
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _levelTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _listSpells(context: context),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatisticCell(
                  info: 'Cecha bazowa',
                  value: widget.characterModel.spellBaseAttribute ?? '',
                  action: widget.userId == widget.characterModel.userId
                      ? () => widget.controller.atributeEditHandle(
                            context,
                            title: 'Edytuj cechę bazową:',
                            updateTargetName: 'spellBaseAttribute',
                            characterId:
                                widget.characterModel.characterId ?? '',
                            atributeType: "text",
                            pathName: 'character',
                          )
                      : () {},
                ),
                StatisticCell(
                  info: 'Komórki czarów',
                  value: widget.characterModel.countSpellCells ?? '',
                  action: widget.userId == widget.characterModel.userId
                      ? () => widget.controller.atributeEditHandle(
                            context,
                            title: 'Edytuj maksymalną ilość komórek:',
                            updateTargetName: 'countSpellCells',
                            characterId:
                                widget.characterModel.characterId ?? '',
                            atributeType: "number",
                            pathName: 'character',
                          )
                      : () {},
                ),
                StatisticCell(
                  info: 'Zużyte komórki',
                  value: widget.characterModel.spellCellsUsed ?? '',
                  action: widget.userId == widget.characterModel.userId
                      ? () => widget.controller.atributeEditHandle(
                            context,
                            title: 'Edytuj zużyte komórki:',
                            updateTargetName: 'spellCellsUsed',
                            characterId:
                                widget.characterModel.characterId ?? '',
                            atributeType: "number",
                            pathName: 'character',
                          )
                      : () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatisticCell(
                  info: 'St rzutu przeciw czarom',
                  value: widget.characterModel.throwAgainstSpells ?? '',
                  action: widget.userId == widget.characterModel.userId
                      ? () => widget.controller.atributeEditHandle(
                            context,
                            title: 'Edytuj rzut przeciw czarom:',
                            updateTargetName: 'throwAgainstSpells',
                            characterId:
                                widget.characterModel.characterId ?? '',
                            atributeType: "number",
                            pathName: 'character',
                          )
                      : () {},
                ),
                StatisticCell(
                  info: 'Premia do ataku czarem',
                  value: widget.characterModel.magicAttackBonus ?? '',
                  action: widget.userId == widget.characterModel.userId
                      ? () => widget.controller.atributeEditHandle(
                            context,
                            title: 'Edytuj premię do ataku czarem:',
                            updateTargetName: 'magicAttackBonus',
                            characterId:
                                widget.characterModel.characterId ?? '',
                            atributeType: "number",
                            pathName: 'character',
                          )
                      : () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listSpells({
    required BuildContext context,
  }) {
    return Container(
      height: 450,
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.userId == widget.characterModel.userId
                  ? _addSpell(context)
                  : SizedBox.shrink(),
              _spellListHeader(context: context),
            ],
          ),
          Container(
            height: 380,
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: widget.controller.spellsSnapshot,
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
                                    widget.characterModel.characterId &&
                                data["level"] == spellsLvl) {
                              return _spell(
                                name: data['name'],
                                context: context,
                                description: data["description"],
                                spellId: document.id,
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
        ],
      ),
    );
  }

  Widget _addSpell(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
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
      child: TextButton(
        onPressed: () => _onButtonPressed(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Dodaj czar",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.appLight,
                  ),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: AppColors.appLight,
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
          return _addSpellBuilder();
        });
  }

  Widget _addSpellBuilder() {
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

                        widget.controller.addSpell(
                            name: _nameTextController.text,
                            timestamp: Timestamp.now(),
                            level: _level,
                            description: _descriptionTextController.text,
                            characterId:
                                widget.characterModel.characterId ?? "");

                        Navigator.pop(context);
                        setState(() {
                          _nameTextController.text = '';
                          _levelTextController.text = '';
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
                    "Nazwa czaru:",
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
                      hintText: "Nazwa czaru",
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
                  TextFormField(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Krąg:",
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
                    child: DropdownButtonFormField(
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: _level,
                      items: _spellsLvl
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setModalState(() {
                          _level = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _spell({
    required String name,
    required String spellId,
    required BuildContext context,
    String? description,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _spellInfoEditHandle(
          context: context,
          name: name,
          description: description ?? "",
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.userId == widget.characterModel.userId
                      ? () {
                          widget.controller.delete(context,
                              id: spellId,
                              collectionName: 'spells',
                              title: 'Czy na pewno chcesz usunąć ten czar?');
                        }
                      : () {},
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
      ),
    );
  }

  Widget _spellListHeader({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          _spellLvlEditHandle(context: context);
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          height: 70,
          width: 70,
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'KRĄG',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Text(
                  spellsLvl,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appLight,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _spellInfoEditHandle({
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

  void _spellLvlEditHandle({required BuildContext context}) {
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
                  'Wybierz Krąg Czarów',
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
                DropdownButton(
                  value: spellsLvl,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30,
                  iconEnabledColor: AppColors.appDark,
                  items: _spellsLvl
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                  color: AppColors.appDark,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      spellsLvl = newValue!;
                    });
                    Navigator.pop(context);
                  },
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
}
