import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class RegisterScreen extends StatelessWidget {
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
          _passwordAgainFormField(),
          SizedBox(
            height: 30,
          ),
          _registerButton(),
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

  Widget _passwordAgainFormField() {
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

  Widget _registerButton() {
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
        onPressed: () {},
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StartPage(),
            ),
          );
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
}
