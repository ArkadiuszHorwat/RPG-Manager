import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/attacksAndMagicCell.dart';
import 'package:rpg_manager/features/characters/character_details/widgets/moneyCell.dart';
import 'package:rpg_manager/features/characters/models/character_model.dart';

class CharacterDetailsEquipment extends StatefulWidget {
  CharacterDetailsEquipment({
    required this.characterModel,
    required this.controller,
  });

  final CharacterModel characterModel;
  final CharacterDetailsScreenController controller;

  @override
  State<CharacterDetailsEquipment> createState() =>
      _CharacterDetailsEquipmentState();
}

class _CharacterDetailsEquipmentState extends State<CharacterDetailsEquipment> {
  final _nameTextController = TextEditingController();
  final _bonusTextController = TextEditingController();
  final _damageTextController = TextEditingController();
  final _damageTypeTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _inventory(context),
            _equipment(context),
          ],
        ),
      ),
    );
  }

  Widget _equipment(BuildContext context) {
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _addItem(
                          context,
                          title: 'Dodaj przedmiot',
                          type: 'item',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: widget.controller.itemsSnapshot,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              return SingleChildScrollView(
                                child: Column(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<dynamic, dynamic> data = document
                                        .data()! as Map<dynamic, dynamic>;

                                    if (data["characterId"] ==
                                        widget.characterModel.characterId) {
                                      return _inventoryElement(
                                        name: data['name'],
                                        context: context,
                                        description: data["description"],
                                        itemId: document.id,
                                      );
                                    } else
                                      return SizedBox.shrink();
                                  }).toList(),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoneyCell(
                      title: 'SM',
                      action: () => widget.controller.atributeEditHandle(
                        context,
                        title: 'Sztuki miedzi',
                        updateTargetName: 'SM',
                        characterId: widget.characterModel.characterId ?? '',
                        atributeType: 'number',
                      ),
                      value: widget.characterModel.sM,
                    ),
                    MoneyCell(
                      title: 'SS',
                      action: () => widget.controller.atributeEditHandle(
                        context,
                        title: 'Sztuki srebra',
                        updateTargetName: 'SS',
                        characterId: widget.characterModel.characterId ?? '',
                        atributeType: 'number',
                      ),
                      value: widget.characterModel.sS,
                    ),
                    MoneyCell(
                      title: 'SE',
                      action: () => widget.controller.atributeEditHandle(
                        context,
                        title: 'Sztuki eledium',
                        updateTargetName: 'SE',
                        characterId: widget.characterModel.characterId ?? '',
                        atributeType: 'number',
                      ),
                      value: widget.characterModel.sE,
                    ),
                    MoneyCell(
                      title: 'SZ',
                      action: () => widget.controller.atributeEditHandle(
                        context,
                        title: 'Sztuki złota',
                        updateTargetName: 'SZ',
                        characterId: widget.characterModel.characterId ?? '',
                        atributeType: 'number',
                      ),
                      value: widget.characterModel.sZ,
                    ),
                    MoneyCell(
                      title: 'SP',
                      action: () => widget.controller.atributeEditHandle(
                        context,
                        title: 'Sztuki platyny',
                        updateTargetName: 'SP',
                        characterId: widget.characterModel.characterId ?? '',
                        atributeType: 'number',
                      ),
                      value: widget.characterModel.sP,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addItem(
    BuildContext context, {
    String? title,
    required String type,
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
          type: type,
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

  void _onButtonPressed(BuildContext context, {required String type}) {
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
          return _addItemBuilder(type: type);
        });
  }

  Widget _addItemBuilder({required String type}) {
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

                        type == 'item'
                            ? widget.controller.addItem(
                                name: _nameTextController.text,
                                timestamp: Timestamp.now(),
                                description: _descriptionTextController.text,
                                characterId:
                                    widget.characterModel.characterId ?? "")
                            : widget.controller.addInUseItem(
                                bonus: _bonusTextController.text,
                                name: _nameTextController.text,
                                damage: _damageTextController.text,
                                damageType: _damageTypeTextController.text,
                                characterId:
                                    widget.characterModel.characterId ?? '',
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
                  type == 'item'
                      ? Column(
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
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
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Premia do ataku:",
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                  color: AppColors.appDark,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _bonusTextController,
                              decoration: InputDecoration(
                                hintText: "Premia do ataku",
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
                              "Obrażenia:",
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                  color: AppColors.appDark,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _damageTextController,
                              decoration: InputDecoration(
                                hintText: "Obrażenia",
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
                              "Typ obrażeń:",
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: TextFormField(
                                controller: _damageTypeTextController,
                                decoration: InputDecoration(
                                  hintText: "Typ obrażeń",
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
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _inventory(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 400,
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
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wyposażenie',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appDark,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      _addItem(
                        context,
                        type: 'inUseItem',
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'nazwa',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'premia do ataku',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'obrażenia/typ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  _equipElementBuilder(),
                  Divider(
                    color: AppColors.appDark,
                  ),
                  AttacksAndMagicCell(
                    controller: widget.controller,
                    characterId: widget.characterModel.characterId ?? '',
                    multiTextValue: widget.characterModel.attacksAndMagic,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _equipElementBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.controller.inUseItemsSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<dynamic, dynamic> data =
                  document.data()! as Map<dynamic, dynamic>;

              if (data["characterId"] == widget.characterModel.characterId) {
                return Column(
                  children: [
                    _equipElement(
                      name: data['name'] ?? '',
                      bonus: data["bonus"] ?? '',
                      damage: data["damage"] ?? '',
                      damageType: data["damageType"] ?? '',
                      context: context,
                      itemInUseId: document.id,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else
                return SizedBox.shrink();
            }).toList(),
          );
        });
  }

  Widget _inventoryElement({
    required String name,
    required String itemId,
    String? description,
    required BuildContext context,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _itemInfoEditHandle(
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
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.controller.delete(context,
                      id: itemId,
                      collectionName: 'items',
                      title: 'Czy na pewno chcesz usunąć ten przedmiot?');
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

  Widget _equipElement({
    required String name,
    required String bonus,
    required String damage,
    required String damageType,
    required BuildContext context,
    required String itemInUseId,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => widget.controller.itemInUseEditHandle(
              context,
              title: 'Edytuj nazwę broni',
              updateTargetName: 'name',
              itemInUseId: itemInUseId,
              hintText: 'Nazwa broni',
              characterId: widget.characterModel.characterId ?? '',
            ),
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: AppColors.appDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              height: 40,
              child: Text(
                name,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appLight,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => widget.controller.itemInUseEditHandle(
              context,
              title: 'Edytuj premię do ataku',
              updateTargetName: 'bonus',
              itemInUseId: itemInUseId,
              hintText: 'Premia do ataku',
              characterId: widget.characterModel.characterId ?? '',
            ),
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: AppColors.appDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              height: 40,
              child: Text(
                bonus,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appLight,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => widget.controller.itemInUseEditHandle(
              context,
              title: 'Edytuj obrażenia oraz ich typ',
              updateTargetName: 'damage',
              updateTargetNameSecond: 'damagaType',
              itemInUseId: itemInUseId,
              hintText: 'Obrażenia',
              hintTextSecond: 'Typ obrażeń',
              characterId: widget.characterModel.characterId ?? '',
            ),
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: AppColors.appDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              height: 40,
              child: Text(
                "$damage / $damageType",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: AppColors.appLight,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {
            widget.controller.delete(context,
                id: itemInUseId,
                collectionName: 'inUseItems',
                title: 'Czy na pewno chcesz usunąć ten przedmiot?');
          },
          icon: Icon(Icons.cancel_outlined),
          color: AppColors.appDark,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
