import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/campaigns/campaigns_controller.dart';
import 'package:rpg_manager/features/campaigns/models/campaign_model.dart';
import 'package:rpg_manager/features/campaigns/widgets/camaigns_card_item.dart';

class CampaignsScreen extends StatefulWidget {
  CampaignsScreen({
    required this.sessionType,
    required this.userId,
  });

  final String sessionType;
  final String userId;

  @override
  _CampaignsScreenState createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  int _selectedValue = 1;
  File? _imageFile;
  final _textController = TextEditingController();
  final _controller = CampaignsScreenController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _controller.campaignsSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Column(
            children: [
              widget.sessionType == 'player'
                  ? SizedBox.shrink()
                  : _addCampaign(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<dynamic, dynamic> data =
                          document.data()! as Map<dynamic, dynamic>;
                      var _currentPlayerId = null;
                      final _playersId = data['playersId'] ?? [];
                      for (String playerId in _playersId) {
                        playerId == widget.userId
                            ? _currentPlayerId = playerId
                            : null;
                      }

                      if ((data['gameMasterId'] == widget.userId &&
                              data['sessionType'] == widget.sessionType) ||
                          (_currentPlayerId != null &&
                              data['sessionType'] != widget.sessionType)) {
                        return CampaignsCardItem(
                          title: data['title'],
                          image: data['image'],
                          controller: _controller,
                          campaignId: document.id,
                        );
                      }

                      return SizedBox.shrink();
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _addCampaign(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2.5,
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        child: TextButton(
          onPressed: () => _onButtonPressed(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  AppLocal.campaignsAddButton,
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
          return _addCampaignBuilder();
        });
  }

  Widget _addCampaignBuilder() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      Future<dynamic> pickImage() async {
        try {
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image == null) return;

          final imageFromGallery = await File(image.path);
          setModalState(() {
            _imageFile = imageFromGallery;
          });
        } on Exception catch (e) {
          print('Coś poszło nie tak: $e');
        }
      }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('OK');
                            print(_imageFile);

                            final campaign = CampaignModel(
                              title: _textController.text,
                              system: _selectedValue == 1
                                  ? 'Warhammer 2ed.'
                                  : 'Dungeons and Dragons 5ed.',
                              image:
                                  _imageFile != null ? _imageFile!.path : null,
                              sessionType: widget.sessionType,
                              gameMasterId: widget.userId,
                              timestamp: Timestamp.now(),
                            );

                            _controller.addCampaigns(
                              campaignModel: campaign,
                            );

                            Navigator.pop(context);
                            setState(() {
                              _selectedValue = 1;
                              _imageFile = null;
                              _textController.text = '';
                            });
                          } else {
                            print('błąd');
                          }
                        },
                        child: Text(
                          AppLocal.campaignsConfirmButton,
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
                  Text(
                    AppLocal.campaignsChooseSystem,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    activeColor: AppColors.appDark,
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: (_) {
                      setModalState(() {
                        _selectedValue = 1;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Warhammer 2ed.',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    activeColor: AppColors.appDark,
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: (_) {
                      setModalState(() {
                        _selectedValue = 2;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Dungeons and Dragons 5ed.',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppLocal.campaignsAddImage,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: pickImage,
                        icon: Icon(
                          Icons.image_outlined,
                          color: AppColors.appDark,
                        ),
                        label: Text(
                          AppLocal.campaignsAddImageInput,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: AppColors.appDark,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      _imageFile != null
                          ? Container(
                              alignment: AlignmentDirectional.center,
                              margin: EdgeInsets.all(10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadiusDirectional.all(
                                    Radius.circular(5)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(_imageFile!.path),
                                    )),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  Text(
                    AppLocal.campaignsSetName,
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
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: AppLocal.campaignsSetNameInput,
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
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
