import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/localizations/app_local.dart';
import 'package:rpg_manager/features/authorization/register/register_controller.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controller = RegisterScreenController();

  var _nameIsValid = false;
  var _emailIsValid = false;
  var _passwordIsValid = false;
  var _confirmPasswordIsValid = false;

  @override
  void initState() {
    super.initState();
    _nameIsValid = true;
    _emailIsValid = true;
    _passwordIsValid = true;
    _confirmPasswordIsValid = true;
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppNavBar(
          title: AppLocal.registerTitle,
        ),
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
      key: _controller.formKey,
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
          _loginButton(context: context),
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
      child: TextFormField(
        controller: _controller.userNameController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: _nameIsValid ? Colors.black : Colors.red,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.face_outlined,
            color: Colors.black45,
            size: 28,
          ),
          hintText: AppLocal.registerNameHintText,
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: _nameIsValid ? Colors.black45 : Colors.red,
              fontSize: 24,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
          ),
        ),
        validator: (userName) {
          if (userName!.isEmpty) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _nameIsValid = false;
              });
            });
            return '';
          } else {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _nameIsValid = true;
              });
            });
          }
        },
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
          hintText: AppLocal.registerEmailHintText,
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
          hintText: AppLocal.registerPasswordHintText,
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
      child: TextFormField(
        controller: _controller.userConfirmPasswordController,
        obscureText: true,
        cursorColor: Colors.black,
        style: TextStyle(
          color: _confirmPasswordIsValid ? Colors.black : Colors.red,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black45,
            size: 28,
          ),
          hintText: AppLocal.registerConfirmHintText,
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: _confirmPasswordIsValid ? Colors.black45 : Colors.red,
              fontSize: 24,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
          ),
        ),
        validator: (userConfirmPassword) {
          if (userConfirmPassword!.isEmpty || userConfirmPassword.length < 6) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _confirmPasswordIsValid = false;
              });
            });
            return '';
          } else {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                _confirmPasswordIsValid = true;
              });
            });
          }
        },
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
            Color.fromARGB(255, 150, 115, 80),
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.black,
          ),
          elevation: MaterialStateProperty.all<double>(
            10,
          ),
        ),
        onPressed: () => _controller.onRegisterButtonPressed(context: context),
        child: Text(
          AppLocal.registerSignUpButtonText,
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

  Widget _loginButton({required BuildContext context}) {
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
          _controller.routeToLoginScreen(context);
        },
        child: Text(
          AppLocal.registerSignInButtonText,
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
