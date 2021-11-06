import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CampaignsCardItem extends StatelessWidget {
  const CampaignsCardItem({
    Key? key,
    required this.title,
    this.image,
  }) : super(key: key);

  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        alignment: AlignmentDirectional.center,
        margin: EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
          image: image == null || !File(image!).existsSync()
              ? DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: AssetImage(
                    'lib/app_assets/images/campaigns-img.jpg',
                  ),
                )
              : DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: FileImage(File(image!)),
                ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.appLight,
            ),
          ),
        ),
      ),
    );
  }
}
