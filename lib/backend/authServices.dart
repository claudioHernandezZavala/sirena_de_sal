import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sirena_de_sal/bounciPageRoute.dart';
import 'package:sirena_de_sal/screens/homepage.dart';

import '../funciones/funciones_firebase.dart';

Future<User?> googleSignIn(BuildContext context) async {
  User? user;
  final fauth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  googleSignIn.signOut();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication auth = await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    try {
      UserCredential userCredential =
          await fauth.signInWithCredential(authCredential);
      user = userCredential.user;
      if (userCredential.additionalUserInfo!.isNewUser) {
        registro(context);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            e.code,
            style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
          ),
        ));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            e.code,
            style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
          ),
        ));
        // handle the error here
      }
    }
  }

  return user;
}

Future<User?> firebaseSignIn(
    String email, String password, BuildContext context) async {
  User? user;
  final firebaseAuth = FirebaseAuth.instance;
  try {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    Navigator.of(context)
        .pushAndRemoveUntil(BouncyPageRoute(HomePage()), (route) => false);
  } on FirebaseAuthException catch (E) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(E.code),
      backgroundColor: Colors.red,
    ));
  }
  return user;
}

Future<User?> firebaseSignUp(
    String email, String password, BuildContext context) async {
  User? user;
  final firebaseAuth = FirebaseAuth.instance;
  try {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    registro(context);
  } on FirebaseAuthException catch (E) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(E.code),
      backgroundColor: Colors.red,
    ));
  }
  return user;
}
