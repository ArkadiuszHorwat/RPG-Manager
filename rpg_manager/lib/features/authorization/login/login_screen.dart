import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/login/login_controller.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginScreenController();

  var _emailIsValid = false;
  var _passwordIsValid = false;

  @override
  void initState() {
    super.initState();
    _emailIsValid = true;
    _passwordIsValid = true;
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppNavBar(
          title: AppLocal.titleStartPage,
          icon: IconButton(
              icon: Icon(
                Icons.close_outlined,
              ),
              onPressed: () {
                _controller.exitAlert(context);
              }),
        ),
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset(
                      'lib/app_assets/images/logo.png',
                      width: 180,
                      height: 180,
                      color: AppColors.appLight,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _loginForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _emailFormField(),
          SizedBox(
            height: 20,
          ),
          _passwordFormField(),
          SizedBox(
            height: 30,
          ),
          _loginButton(context: context),
          SizedBox(
            height: 20,
          ),
          _registerButton(context),
        ],
      ),
    );
  }

  Widget _emailFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.appLight,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        controller: _controller.userEmailController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: _emailIsValid ? Colors.black : Colors.red,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black45,
            size: 28,
          ),
          hintText: AppLocal.loginEmailHintText,
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: _emailIsValid ? Colors.black45 : Colors.red,
              fontSize: 24,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
          ),
        ),
        validator: (userEmail) {
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = new RegExp(pattern);

          if (userEmail != null && regex.hasMatch(userEmail)) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _emailIsValid = true;
              });
            });
          } else {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _emailIsValid = false;
              });
            });
            return '';
          }
        },
      ),
    );
  }

  Widget _passwordFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.appLight,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        controller: _controller.userPasswordController,
        obscureText: true,
        cursorColor: Colors.black,
        style: TextStyle(
          color: _passwordIsValid ? Colors.black : Colors.red,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black45,
            size: 28,
          ),
          hintText: AppLocal.loginPasswordHintText,
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: _passwordIsValid ? Colors.black45 : Colors.red,
              fontSize: 24,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
          ),
        ),
        validator: (userPassword) {
          if (userPassword!.length < 6) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _passwordIsValid = false;
              });
            });
            return '';
          } else {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _passwordIsValid = true;
              });
            });
          }
        },
      ),
    );
  }

  Widget _loginButton({required BuildContext context}) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(15.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 150, 115, 80),
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.black,
          ),
          elevation: MaterialStateProperty.all<double>(
            10,
          ),
        ),
        onPressed: () => _controller.onLoginButtonPressed(context: context),
        child: Text(
          AppLocal.loginSignInButtonText,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: AppColors.appLight,
              letterSpacing: 1.5,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.appLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(15.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {
          _controller.routeToRegistration(context);
        },
        child: Text(
          AppLocal.loginSignUpButtonText,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: AppColors.appLight,
              letterSpacing: 1.5,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
