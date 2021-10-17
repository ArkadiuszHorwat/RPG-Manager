import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:provider/provider.dart';
import 'package:rpg_manager/setup/routes_setup.dart';

class LoginScreenController {
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onLoginButtonPressed({required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      context.read<FirebaseAuthentication>().login(
            userEmailController.text,
            userPasswordController.text,
          );
    } else {
      showErrorLogin(text: AppLocal.loginErrorText);
    }
  }

  void showErrorLogin({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: AppColors.appLight,
      fontSize: 16.0,
    );
  }

  void exitAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Text(AppLocal.loginExitTitle),
            actions: [
              TextButton(
                onPressed: () {
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
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
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

  void routeToRegistration(BuildContext context) {
    Navigator.of(context).pushNamed(RoutePageName.register);
  }
}
