import 'package:flutter/material.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/setup/setup.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Setup.setupInitialize();
  initializeDateFormatting().then((_) => runApp(App()));
}
