import 'package:fire_base_first/view/logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  
  Future<void> signIn(
      String userName, String passWord, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: passWord)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              duration: const Duration(seconds: 2),
              elevation: 25,
              backgroundColor: const Color.fromARGB(255, 255, 2, 2),
              content: Text(
                textAlign: TextAlign.center,
                value.toString(),
              ))))
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoggedIn()),
              (route) => false));
    } on FirebaseAuthException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 2),
          elevation: 25,
          backgroundColor: const Color.fromARGB(255, 255, 2, 2),
          content: Text(
            textAlign: TextAlign.center,
            exception.message.toString(),
          )));
    }
  }

  Future<void> signUp(
      String userName, String passWord, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: passWord)
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  duration: Duration(seconds: 2),
                  elevation: 25,
                  backgroundColor: Color.fromARGB(255, 255, 2, 2),
                  content: Text(
                    textAlign: TextAlign.center,
                    'Successfully Registered',
                  ))))
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoggedIn()),
              (route) => false));
    } on FirebaseAuthException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 2),
          elevation: 25,
          backgroundColor: const Color.fromARGB(255, 255, 2, 2),
          content: Text(
            textAlign: TextAlign.center,
            exception.message.toString(),
          )));
    }
  }
}
