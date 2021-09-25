import 'package:flutter/cupertino.dart';

class AppBackground extends StatelessWidget {
  AppBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/app_assets/images/background-img.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
