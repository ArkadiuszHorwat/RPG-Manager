import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/campaigns/campaign_details/campaign_details_screen_controller.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/features/characters/characters_controller.dart';

class CampaignImage extends StatefulWidget {
  CampaignImage({
    required this.campaignModel,
    required this.controller,
    required this.sessionType,
    required this.userId,
  });

  final CampaignModel campaignModel;
  final CampaignDetailsScreenController controller;
  final String sessionType;
  final String userId;

  @override
  State<CampaignImage> createState() => _CampaignImageState();
}

class _CampaignImageState extends State<CampaignImage> {
  final _emailTextController = TextEditingController();
  final _characterController = CharactersScreenController();
  final formKey = GlobalKey<FormState>();
  var _sessionStatus;
  var _playerStatus = false;

  @override
  void initState() {
    super.initState();
    _sessionStatus = widget.campaignModel.sessionStatus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsetsDirectional.all(10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.sessionType == 'game master'
                ? () {
                    _imageEditHandle(context);
                  }
                : () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                image: widget.campaignModel.image == null ||
                        !File(widget.campaignModel.image!).existsSync()
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'lib/app_assets/images/campaigns-img.jpg',
                        ),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(widget.campaignModel.image!)),
                      ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.sessionType == 'game master'
                        ? () => _sessionNumberInfo(context)
                        : () {},
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        top: 10,
                        start: 10,
                      ),
                      clipBehavior: Clip.none,
                      height: 65,
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
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sesja',
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: AppColors.appDark,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            widget.campaignModel.sessionNumber.toString(),
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: AppColors.appDark,
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.none,
                    width: 155,
                    padding: EdgeInsetsDirectional.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.appLight,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          spreadRadius: 0.5,
                        ),
                      ],
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          widget.campaignModel.system,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.sessionType == 'game master'
                      ? _addPlayer(context, 'Dodaj gracza')
                      : SizedBox.shrink(),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      bottom: 10,
                      end: 10,
                    ),
                    clipBehavior: Clip.none,
                    height: 65,
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
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10)),
                    ),
                    child: widget.sessionType == 'game master'
                        ? IconButton(
                            icon: _sessionStatus
                                ? Icon(Icons.logout_outlined)
                                : Icon(Icons.login_outlined),
                            onPressed: () {
                              _sessionStatus
                                  ? _sessionStatus = false
                                  : _sessionStatus = true;
                              widget.controller.updateCampaign(
                                campaignId: widget.campaignModel.campaignId!,
                                newValue: _sessionStatus,
                                updateTargetName: 'sessionStatus',
                              );
                            },
                            color: AppColors.appDark,
                            iconSize: 32,
                          )
                        : IconButton(
                            icon: _playerStatus
                                ? Icon(Icons.logout_outlined)
                                : Icon(Icons.login_outlined),
                            onPressed: () {
                              _playerStatus
                                  ? widget.controller.deleteActivePlayer(
                                      campaignId:
                                          widget.campaignModel.campaignId!,
                                      value: '', //TODO: set correct value
                                    )
                                  : _addCharacterToCampaign(context);
                            },
                            color: AppColors.appDark,
                            iconSize: 32,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addCharacterToCampaign(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setModalState) {
            return AlertDialog(
              backgroundColor: AppColors.appLight,
              title: Column(
                children: [
                  Divider(
                    color: AppColors.appDark,
                  ),
                  Text(
                    'Wybierz postać',
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
                  StreamBuilder<QuerySnapshot>(
                      stream: _characterController.charactersSnapshot,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        var charactersList = <String>[];
                        Map<String, dynamic> charactersId = Map();

                        if (snapshot.data != null) {
                          snapshot.data!.docs
                              .map<void>((DocumentSnapshot document) {
                            Map<dynamic, dynamic> data =
                                document.data()! as Map<dynamic, dynamic>;
                            if (data["userId"] == widget.userId) {
                              charactersList.add(data['name']);
                              charactersId.addAll({
                                data['name']: document.id,
                              });
                            }
                          }).toList();

                          var _initValue = charactersList.first;

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: _initValue,
                              items: charactersList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setModalState(() {
                                  _initValue = newValue!;

                                  widget.controller.updateCampaign(
                                    campaignId:
                                        widget.campaignModel.campaignId!,
                                    newValue: charactersId[_initValue],
                                    updateTargetName: 'activePlayers',
                                  );
                                  Navigator.pop(context);
                                  setState(() {
                                    _playerStatus = true;
                                  });
                                });
                              },
                            ),
                          );
                        }

                        return SizedBox.shrink();
                      }),
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
        });
  }

  void _imageEditHandle(BuildContext context) {
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
                  'Edytuj obraz',
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
                onPressed: () async {
                  try {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    final imageFromGallery = await File(image.path);

                    CollectionReference campaigns =
                        FirebaseFirestore.instance.collection('campaigns');

                    campaigns
                        .doc('${widget.campaignModel.campaignId}')
                        .update({'image': imageFromGallery.path})
                        .then((value) => print('image was updated'))
                        .catchError((error) => print('Failed to update image'));
                  } on Exception catch (e) {
                    print('Coś poszło nie tak: $e');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Zmień',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  CollectionReference campaigns =
                      FirebaseFirestore.instance.collection('campaigns');

                  campaigns
                      .doc('${widget.campaignModel.campaignId}')
                      .update({'image': FieldValue.delete()})
                      .then((value) => print('image deleted'))
                      .catchError((error) => print('Failed to delete image'));
                  Navigator.pop(context);
                },
                child: Text(
                  'Usuń',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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

  void _sessionNumberInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, StateSetter setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.appLight,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      CollectionReference campaigns =
                          FirebaseFirestore.instance.collection('campaigns');

                      campaigns
                          .doc('${widget.campaignModel.campaignId}')
                          .update({
                            'sessionNumber':
                                widget.campaignModel.sessionNumber! + 1
                          })
                          .then((value) => print('Session number updated'))
                          .catchError((error) =>
                              print('Failed to update session number'));
                      Navigator.pop(context);
                    },
                    child: Text(
                      '+',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.campaignModel.sessionNumber! > 0) {
                        CollectionReference campaigns =
                            FirebaseFirestore.instance.collection('campaigns');

                        campaigns
                            .doc('${widget.campaignModel.campaignId}')
                            .update({
                              'sessionNumber':
                                  widget.campaignModel.sessionNumber! - 1
                            })
                            .then((value) => print('Session number updated'))
                            .catchError((error) =>
                                print('Failed to update session number'));
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      '-',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: AppColors.appDark,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
        });
  }

  Widget _addPlayer(
    BuildContext context,
    String? title,
  ) {
    return Container(
      height: 50,
      width: 170,
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        color: AppColors.appLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(5),
        ),
      ),
      child: TextButton(
        onPressed: () => _onButtonPressed(
          context,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title ?? '',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.appDark,
                  ),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: AppColors.appDark,
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(
    BuildContext context,
  ) {
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
          return _addItemBuilder(context);
        });
  }

  Widget _addItemBuilder(BuildContext context) {
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

                      widget.controller.addPlayer(
                        playerMail: _emailTextController.text,
                        campaignId: widget.campaignModel.campaignId!,
                        context: context,
                      );

                      Navigator.pop(context);
                      setState(() {
                        _emailTextController.text = '';
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
                  "Email gracza:",
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
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      hintText: "Email gracza",
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
          ),
        ],
      ),
    );
  }
}
