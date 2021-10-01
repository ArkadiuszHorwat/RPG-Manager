import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:rpg_manager/setup/routes_setup.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      backgroundColor: Colors.transparent,
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
      key: _formKey,
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
        controller: _userEmailController,
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
          hintText: 'E-mail',
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
        controller: _userPasswordController,
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
          hintText: 'Hasło',
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
            Color.fromARGB(255, 168, 128, 92),
          ),
        ),
        onPressed: () => _onLoginButtonPressed(context: context),
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

  Widget _registerButton(BuildContext context) {
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
          Navigator.of(context).pushNamed(RoutePageName.register);
        },
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

  void _onLoginButtonPressed({required BuildContext context}) {
    try {
      if (_formKey.currentState!.validate()) {
        context.read<FirebaseAuthentication>().login(
              _userEmailController.text,
              _userPasswordController.text,
            );

        Navigator.of(context).pushNamed(RoutePageName.startPage);
        Fluttertoast.showToast(
          msg: "Logowanie powiodło się",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 247, 241, 227),
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Logowanie nie powiodło się",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Color.fromARGB(255, 247, 241, 227),
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      _userEmailController.text = '';
      _userPasswordController.text = '';
    }
  }
}
