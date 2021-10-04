import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  AppNavBar({
    this.title,
    this.icon,
  });

  final String? title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? '',
        style: GoogleFonts.rubik(
          textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 247, 241, 227),
          ),
        ),
      ),
      centerTitle: true,
      leading: icon,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 247, 241, 227),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
