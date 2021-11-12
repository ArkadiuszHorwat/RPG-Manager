import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';

class ThrowAgainstDeath extends StatefulWidget {
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
                            _lifeCheck >= 1
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _lifeCheck >= 1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            _lifeCheck >= 2
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _lifeCheck >= 2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            _lifeCheck >= 3
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: _lifeCheck == 3
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            _deathCheck <= -1
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: _deathCheck <= -1
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            _deathCheck <= -2
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: _deathCheck <= -2
                                ? AppColors.appDark
                                : Colors.grey,
                          ),
                          Icon(
                            _deathCheck <= -3
                                ? Icons.cancel
                                : Icons.cancel_outlined,
                            color: _deathCheck == -3
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
                onPressed: () {
                  setState(() => _deathCheck--);
                  if (_deathCheck == -3) {
                    setState(() => _deathCheck = 0);
                    setState(() => _lifeCheck = 0);
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
                onPressed: () {
                  setState(() => _lifeCheck++);
                  if (_lifeCheck == 3) {
                    setState(() => _lifeCheck = 0);
                    setState(() => _deathCheck = 0);
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
