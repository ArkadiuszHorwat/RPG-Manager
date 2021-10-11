import 'package:flutter/material.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/setup/setup.dart';

void main() async {
  await Setup.setupInitialize();
  runApp(App());
}
