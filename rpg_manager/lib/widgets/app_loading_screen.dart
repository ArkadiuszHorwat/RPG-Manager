import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingScreen extends StatefulWidget {
  AppLoadingScreen({
    required this.color,
    this.width,
    this.height,
  });

  final Color color;
  final double? width;
  final double? height;

  @override
  State<AppLoadingScreen> createState() => _AppLoadingScreenState();
}

class _AppLoadingScreenState extends State<AppLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000000),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 100.0).animate(_controller),
        child: Image.asset(
          'lib/app_assets/images/logo.png',
          width: widget.width ?? 150,
          height: widget.height ?? 150,
          color: widget.color,
        ),
      ),
    );
  }
}
