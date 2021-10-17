import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/campaigns/campaigns_controller.dart';
import 'package:rpg_manager/features/campaigns/widgets/campaigns_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final testCampaignsList = [
  'Zapomniana kopalnia Phandelvera',
  'Język smoka',
  'Wrota Baldura',
  'Artefakt demona',
  'Cienie Amn',
  'Zaginiony kupiec',
];

class CampaignsScreen extends StatefulWidget {
  CampaignsScreen({
    required this.sessionType,
  });

  final String sessionType;

  @override
  _CampaignsScreenState createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  final _controller = CampaignsScreenController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.sessionType == 'player'
            ? SizedBox.shrink()
            : _addCampaign(context),
        Expanded(
          child: SingleChildScrollView(
            child: CampaignsList(
              data: testCampaignsList,
            ),
          ),
        ),
      ],
    );
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.appLight,
        builder: (context) {
          int _selectedValue = 1;

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            // Future<File> saveImagePermanently(String imagePath) async {
            //   final directiory = await getApplicationDocumentsDirectory();
            //   final name = basename(imagePath);
            //   final image = File('${directiory.path}/$name');

            //   return File(imagePath).copy(image.path);
            // }

            Future<dynamic> pickImage() async {
              try {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) return;

                final imageFromGallery = await File(image.path);
                setModalState(() {
                  this.image = imageFromGallery;
                });
              } on Exception catch (e) {
                print('Coś poszło nie tak: $e');
              }
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ZATWIERDŹ',
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
                    'Wybierz system:',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dodaj obraz:',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appDark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      image != null
                          ? Image.file(
                              image!,
                              width: 50,
                              height: 50,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => pickImage(),
                    icon: Icon(
                      Icons.image_outlined,
                      color: AppColors.appDark,
                    ),
                    label: Text(
                      'Dodaj obraz',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: AppColors.appDark,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Nazwa kampanii:',
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'nazwa kampanii...',
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
            );
          });
        });
  }
}
