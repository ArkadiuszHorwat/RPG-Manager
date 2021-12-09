import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CampaignPlayersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: _infoContainer(),
    );
  }

  Widget _infoContainer() {
    return Container(
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
                    'Aktywni gracze',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: AppColors.appDark,
                  ),
                  _listElement(name: 'asd')
                ],
              ),
              // child: StreamBuilder<QuerySnapshot>(
              //         stream: _currentSnapshot,
              //         builder: (context, snapshot) {
              //           if (snapshot.hasError) {
              //             return Text('Something went wrong');
              //           }

              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Text("Loading");
              //           }

              //           return SingleChildScrollView(
              //             child: Column(
              //               children: snapshot.data!.docs
              //                   .map((DocumentSnapshot document) {
              //                 Map<dynamic, dynamic> data =
              //                     document.data()! as Map<dynamic, dynamic>;

              //                 if (data["characterId"] ==
              //                     widget.characterModel.characterId) {
              //                   return _listElement(
              //                     name: data['name'],
              //                     context: context,
              //                     description: data["description"],
              //                     elementId: document.id,
              //                     collectionName: collectionName,
              //                   );
              //                 } else
              //                   return SizedBox.shrink();
              //               }).toList(),
              //             ),
              //           );
              //         }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listElement({
    required String name,
    // required String elementId,
    // required String collectionName,
    // String? description,
    // required BuildContext context,
    // String? value,
    // String? updateTargetName,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
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
}
