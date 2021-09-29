import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:rpg_manager/setup/routes_setup.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userConfirmPasswordController = TextEditingController();
  //TODO: add method which push user data to database after sign up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(
        title: 'REJESTRACJA',
      ),
      body: AppBackground(
        child: GestureDetector(
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
                      width: 100,
                      height: 100,
                      color: Color.fromARGB(255, 247, 241, 227),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _registerForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _userNameFormField(),
          SizedBox(
            height: 20,
          ),
          _emailFormField(),
          SizedBox(
            height: 20,
          ),
          _passwordFormField(),
          SizedBox(
            height: 20,
          ),
          _confirmPasswordFormField(),
          SizedBox(
            height: 30,
          ),
          _registerButton(context: context),
          SizedBox(
            height: 20,
          ),
          _loginButton(context),
        ],
      ),
    );
  }

  Widget _userNameFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 241, 227),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextField(
        controller: _userNameController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.face_outlined,
            color: Colors.black45,
            size: 28,
          ),
          hintText: 'Nazwa użytkownika',
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.black45,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 241, 227),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextField(
        controller: _userEmailController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black45,
            size: 28,
          ),
          hintText: 'E-mail',
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.black45,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 241, 227),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextField(
        controller: _userPasswordController,
        obscureText: true,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black45,
            size: 28,
          ),
          hintText: 'Hasło',
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.black45,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmPasswordFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 241, 227),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 60.0,
      child: TextField(
        controller: _userConfirmPasswordController,
        obscureText: true,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black45,
            size: 28,
          ),
          hintText: 'Potwierdź hasło',
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.black45,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton({required BuildContext context}) {
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
            Color.fromARGB(255, 168, 128, 92),
          ),
        ),
        onPressed: () => _onRegisterButtonPressed(context: context),
        child: Text(
          'ZAREJESTRUJ SIĘ',
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 247, 241, 227),
              letterSpacing: 1.5,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 247, 241, 227),
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
          Navigator.of(context).pushNamed(RoutePageName.startPage);
        },
        child: Text(
          'LOGOWANIE',
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 247, 241, 227),
              letterSpacing: 1.5,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonPressed({required BuildContext context}) async {
    try {
      await context.read<FirebaseAuthentication>().register(
            _userNameController.text,
            _userEmailController.text,
            _userPasswordController.text,
          );

      Navigator.of(context).pushNamed(RoutePageName.startPage);
    } catch (e) {
      print(e);
      _userNameController.text = '';
      _userEmailController.text = '';
      _userPasswordController.text = '';
      _userConfirmPasswordController.text = '';
    }
  }
}
