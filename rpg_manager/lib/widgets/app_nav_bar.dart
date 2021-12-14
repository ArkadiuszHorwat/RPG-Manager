import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  AppNavBar({
    this.title,
    this.icon,
    this.actions,
  });

  final String? title;
  final Widget? icon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? '',
        style: GoogleFonts.rubik(
          textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.appLight,
          ),
        ),
      ),
      centerTitle: false,
      leading: icon,
      iconTheme: IconThemeData(
        color: AppColors.appLight,
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
