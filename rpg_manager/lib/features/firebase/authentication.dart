import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpg_manager/features/firebase/config.dart';

class FirebaseAuthentication {
  FirebaseAuthentication(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Successfully Logged In :)');
      _showInfo(text: 'Siedzicie w karczmie...');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _showError(text: 'Brak takiego użytkownika');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _showError(text: 'Błędne hasło');
      }
      print(e.message);
    }
  }

  Future<void> register(String userName, String email, String password) async {
    try {
      final users =
          FlutterFirebaseConfig.getFirestoreConnect().collection('users');

      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) async {
        final userData = userCredential.user;
        print('$userData - user data');
        await users.doc(userData!.uid).set({
          'name': userName,
          'email': email,
        }).then(
          (_) {
            print('Successfully Sign Up :)');
            _showInfo(text: 'Czas wyruszać...');
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _showError(text: 'Słaby rzut na hasło');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _showError(text: 'Ten bohater już wyruszył na szlak');
      }
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('Log out :(');
  }
}

void _showError({required String text}) {
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

void _showInfo({required String text}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.greenAccent,
    textColor: Color.fromARGB(255, 247, 241, 227),
    fontSize: 16.0,
  );
}
