import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/features/firebase/authentication.dart';
import 'package:rpg_manager/setup/routes_setup.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userConfirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
          title: 'Rejestracja',
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
      key: _formKey,
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
        controller: _userNameController,
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
          hintText: 'Nazwa użytkownika',
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
        controller: _userConfirmPasswordController,
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
          hintText: 'Potwierdź hasło',
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
    if (_formKey.currentState!.validate() &&
        _userPasswordController.text == _userConfirmPasswordController.text) {
      await context.read<FirebaseAuthentication>().register(
            _userNameController.text,
            _userEmailController.text,
            _userPasswordController.text,
          );

      Navigator.of(context).pushNamed(RoutePageName.startPage);
    } else {
      _showErrorRegister(text: "Rejestracja nie powiodła się");
    }
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
