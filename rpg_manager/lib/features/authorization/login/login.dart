import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    width: 180,
                    height: 180,
                    color: Color.fromARGB(255, 247, 241, 227),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _loginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
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
          _loginButton(),
          SizedBox(
            height: 20,
          ),
          _registerButton(),
        ],
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
          hintText: 'e-mail',
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
          hintText: 'hasło',
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

  Widget _loginButton() {
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
          'ZALOGUJ SIĘ',
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

  Widget _registerButton() {
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
        onPressed: () {},
        child: Text(
          'REJESTRACJA',
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
