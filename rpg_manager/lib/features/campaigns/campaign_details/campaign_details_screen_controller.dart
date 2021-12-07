import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CampaignDetailsScreenController {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCampaignDetails(
      {required String campaignId}) {
    return FirebaseFirestore.instance
        .collection('campaigns')
        .doc(campaignId)
        .snapshots();
  }

  final campaigns = FirebaseFirestore.instance.collection('campaigns');
  final users = FirebaseFirestore.instance.collection('users');

  Future<void> addPlayer({
    required String playerMail,
    required String campaignId,
    required BuildContext context,
  }) {
    var _userId = '';
    return users.where('email', isEqualTo: playerMail).get().then((value) {
      _userId = value.docs.single.id;
      campaigns
          .doc(campaignId)
          .update({
            'playersId': FieldValue.arrayUnion([_userId]),
          })
          .then((value) => print("campaigns Added"))
          .catchError((error) => print("Failed to add campaigns: $error"));
      // ignore: invalid_return_type_for_catch_error
    }).catchError((_) => errorDialog(context));
  }

  void updateCampaign({
    required String campaignId,
    required dynamic newValue,
    required String updateTargetName,
  }) {
    try {
      campaigns
          .doc(campaignId)
          .update({
            updateTargetName: newValue,
          })
          .then((value) => print('$updateTargetName was update'))
          .catchError((error) => print('Failed to update $updateTargetName'));
    } on Exception catch (e) {
      print('Coś poszło nie tak: $e');
    }
  }

  void descriptionEditHandle(
    BuildContext context, {
    required String title,
    String? hintText,
    required String updateTargetName,
    String? campaignId,
    String? campaignMultiText,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();
          final formKey = GlobalKey<FormState>();

          if (campaignMultiText != null) {
            textController.text = campaignMultiText;
          }

          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  title,
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
                Container(
                  height: campaignMultiText != null ? 250 : 50,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 15,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      autofocus: false,
                      validator: (text) {
                        if (text != null) {
                          print('fajen');
                        } else {
                          print('niefajen');
                          return '';
                        }
                      },
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
                  updateCampaign(
                    campaignId: campaignId ?? '',
                    updateTargetName: updateTargetName,
                    newValue: textController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'Zapisz',
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

  void _deleteCampaign({required String campaignId}) {
    try {
      campaigns
          .doc(campaignId)
          .delete()
          .then((value) => print('campaign was deleted'))
          .catchError((error) => print('Failed to delete campaign'));
    } on Exception catch (e) {
      print('Coś poszło nie tak: $e');
    }
  }

  void campaignDelete(BuildContext context, {required String campaignId}) {
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
                  'Napewno chcesz usunąć kampanie?',
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
                  Navigator.pop(context);
                  _deleteCampaign(campaignId: campaignId);
                },
                child: Text(
                  'Tak',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Nie',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void errorDialog(BuildContext context) {
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
                  'Brak takiego adresu email',
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
