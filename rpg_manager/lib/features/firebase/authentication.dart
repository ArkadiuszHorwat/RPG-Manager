import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
        await users
            .doc(userData!.uid)
            .set({
              'name': userName,
              'email': email,
            })
            .then(
              (_) => print('Successfully Sign Up :)'),
            )
            .catchError(
              (e) => print('$e - error'),
            );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('Log out :(');
  }
}
