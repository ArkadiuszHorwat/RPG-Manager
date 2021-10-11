import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:provider/provider.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class RegisterScreenController {
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userConfirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onRegisterButtonPressed({required BuildContext context}) async {
    if (formKey.currentState!.validate() &&
        userPasswordController.text == userConfirmPasswordController.text) {
      await context.read<FirebaseAuthentication>().register(
            userNameController.text,
            userEmailController.text,
            userPasswordController.text,
          );

      Navigator.of(context).pushNamed(RoutePageName.startPage);
    } else {
      _showErrorRegister(text: AppLocal.registerErrorText);
    }
  }

  void _showErrorRegister({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Color.fromARGB(255, 247, 241, 227),
      fontSize: 16.0,
    );
  }

  void routeToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutePageName.startPage);
  }
}
