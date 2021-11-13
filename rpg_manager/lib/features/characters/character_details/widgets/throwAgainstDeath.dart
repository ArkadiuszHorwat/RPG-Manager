import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';

class ThrowAgainstDeath extends StatefulWidget {
  ThrowAgainstDeath({
    required this.characterId,
    required this.deathCheck,
    required this.lifeCheck,
  });

  final String characterId;
  final int deathCheck;
  final int lifeCheck;

  @override
  State<ThrowAgainstDeath> createState() => _ThrowAgainstDeathState();
}

class _ThrowAgainstDeathState extends State<ThrowAgainstDeath> {
  var _deathCheck = 0;
  var _lifeCheck = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _characterThrowsAgainstDeath(context),
    );
  }

  Widget _characterThrowsAgainstDeath(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => _throwAgainstDeathChoose(context),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.appLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rzuty przeciw śmierci',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            widget.lifeCheck >= 1
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: widget.lifeCheck >= 1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            widget.lifeCheck >= 2
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: widget.lifeCheck >= 2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            widget.lifeCheck >= 3
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: widget.lifeCheck == 3
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            widget.deathCheck <= -1
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: widget.deathCheck <= -1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            widget.deathCheck <= -2
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: widget.deathCheck <= -2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            widget.deathCheck <= -3
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: widget.deathCheck == -3
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _throwAgainstDeathChoose(BuildContext context) {
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
                  'Znów uciekniesz śmierci?',
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
                  CollectionReference characters =
                      FirebaseFirestore.instance.collection('characters');

                  await characters
                      .doc('${widget.characterId}')
                      .update({'deathCheck': widget.deathCheck - 1})
                      .then((value) => print('Death updated'))
                      .catchError((error) => print('Failed to update death'));

                  if (widget.deathCheck == -3) {
                    characters
                        .doc('${widget.characterId}')
                        .update({'deathCheck': 0})
                        .then((value) => print('Death updated'))
                        .catchError((error) => print('Failed to update death'));

                    characters
                        .doc('${widget.characterId}')
                        .update({'lifeCheck': 0})
                        .then((value) => print('Death updated'))
                        .catchError((error) => print('Failed to update death'));
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonNoText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  CollectionReference characters =
                      FirebaseFirestore.instance.collection('characters');

                  await characters
                      .doc('${widget.characterId}')
                      .update({'lifeCheck': widget.lifeCheck + 1})
                      .then((value) => print('Death updated'))
                      .catchError((error) => print('Failed to update death'));

                  if (widget.lifeCheck == 3) {
                    characters
                        .doc('${widget.characterId}')
                        .update({'deathCheck': 0})
                        .then((value) => print('Death updated'))
                        .catchError((error) => print('Failed to update death'));

                    characters
                        .doc('${widget.characterId}')
                        .update({'lifeCheck': 0})
                        .then((value) => print('Death updated'))
                        .catchError((error) => print('Failed to update death'));
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  AppLocal.commonYesText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
