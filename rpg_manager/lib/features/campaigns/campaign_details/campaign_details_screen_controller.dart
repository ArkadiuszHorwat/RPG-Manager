import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CampaignDetailsScreenController {
  var _userId = '';
  var _campaignNotesId = '';

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCampaignDetails(
      {required String campaignId}) {
    return campaigns.doc(campaignId).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCampaignNotes(
      {required String campaignId, required String userId}) {
    return campaignNotes
        .where('campaignId', isEqualTo: campaignId)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((value) {
      print('test: ${value.docs.single}');
      return value.docs.single;
    });
  }

  final campaigns = FirebaseFirestore.instance.collection('campaigns');
  final characters = FirebaseFirestore.instance.collection('characters');
  final campaignNotes = FirebaseFirestore.instance.collection('campaignNotes');
  final users = FirebaseFirestore.instance.collection('users');

  Future<void> addPlayer({
    required String playerMail,
    required String campaignId,
    required BuildContext context,
  }) {
    return users.where('email', isEqualTo: playerMail).get().then((value) {
      _userId = value.docs.single.id;
      campaigns.doc(campaignId).update({
        'playersId': FieldValue.arrayUnion([_userId]),
      }).then((value) {
        print("campaigns Added");
        campaignNotes.add({
          'campaignId': campaignId,
          'userId': _userId,
        });
        // ignore: invalid_return_type_for_catch_error
      }).catchError((error) => print("Failed to add campaigns: $error"));
      // ignore: invalid_return_type_for_catch_error
    }).catchError((_) => errorDialog(context));
  }

  void updateCampaign({
    required String campaignId,
    String? userId,
    bool notesUpdate = false,
    required dynamic newValue,
    required String updateTargetName,
  }) {
    try {
      if (updateTargetName == 'activePlayers') {
        characters
            .doc(newValue)
            .update({
              "activeCampaign": true,
            })
            .then((value) => print('active campaign was update'))
            .catchError((error) => print('Failed to update active campaign'));

        users
            .doc(userId)
            .update({
              "activeUser": true,
            })
            .then((value) => print('activeUser was update'))
            .catchError((error) => print('Failed to update activeUser'));
      }

      if (updateTargetName == 'sessionStatus' && newValue == false) {
        campaigns
            .doc(campaignId)
            .update({
              "activePlayers": [],
            })
            .then((value) => print('active campaign was update'))
            .catchError((error) => print('Failed to update active campaign'));
      }

      notesUpdate
          ? campaignNotes
              .where('campaignId', isEqualTo: campaignId)
              .where('userId', isEqualTo: userId)
              .get()
              .then((value) {
              _campaignNotesId = value.docs.single.id;
              campaignNotes
                  .doc(_campaignNotesId)
                  .update({
                    updateTargetName: newValue,
                  })
                  .then((value) => print('$updateTargetName was update'))
                  .catchError(
                      (error) => print('Failed to update $updateTargetName'));
            })
          : campaigns
              .doc(campaignId)
              .update({
                updateTargetName: updateTargetName == 'activePlayers'
                    ? FieldValue.arrayUnion([newValue])
                    : newValue,
              })
              .then((value) => print('$updateTargetName was update'))
              .catchError(
                  (error) => print('Failed to update $updateTargetName'));
    } on Exception catch (e) {
      print('Co?? posz??o nie tak: $e');
    }
  }

  void deleteActivePlayer({
    required String campaignId,
    required String userId,
  }) {
    try {
      characters
          .where("userId", isEqualTo: userId)
          .where("activeCampaign", isEqualTo: true)
          .get()
          .then((value) {
        final _characterId = value.docs.single.id;
        characters
            .doc(_characterId)
            .update({
              "activeCampaign": false,
            })
            .then((value) => print('active campaign was update'))
            .catchError((error) => print('Failed to update active campaign'));

        campaigns
            .doc(campaignId)
            .update({
              'activePlayers': FieldValue.arrayRemove([_characterId]),
            })
            .then((value) => print('activePlayers was delete'))
            .catchError((error) => print('Failed to delete activePlayers'));

        users
            .doc(userId)
            .update({
              "activeUser": false,
            })
            .then((value) => print('activeUser was update'))
            .catchError((error) => print('Failed to update activeUser'));
      });
    } on Exception catch (e) {
      print('Co?? posz??o nie tak: $e');
    }
  }

  void descriptionEditHandle(
    BuildContext context, {
    required String title,
    String? hintText,
    required String updateTargetName,
    String? campaignId,
    String? campaignMultiText,
    String? userId,
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
                    userId: userId ?? '',
                    notesUpdate: true,
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
                  'Wr????',
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
      print('Co?? posz??o nie tak: $e');
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
                  'Napewno chcesz usun???? kampanie?',
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
                  'Wr????',
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
