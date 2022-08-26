import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_first/controller/logged_in_provider.dart';
import 'package:fire_base_first/core/image.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:fire_base_first/view/logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  String signUpImage = selectedImage;

  Future<void> signIn(
      String userName, String passWord, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: passWord)
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  duration: Duration(seconds: 2),
                  elevation: 25,
                  backgroundColor: Color.fromARGB(255, 255, 2, 2),
                  content: Text(
                    textAlign: TextAlign.center,
                    'Logged In successfully',
                  )))).then((value) => context.read<LoggedInProv>().getUserDetails(userName))
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

  Future<void> signUp(String userName, String passWord, BuildContext context,
      UserModel data) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: passWord)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            duration: Duration(seconds: 2),
            elevation: 25,
            backgroundColor: Color.fromARGB(255, 255, 2, 2),
            content: Text(
              textAlign: TextAlign.center,
              'Successfully Registered',
            )));
      }).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoggedIn()),
            (route) => false);
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .set(data.toMapped());
      });
      resetImage();
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

  Future<void> pickimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(image!.path).readAsBytesSync();
    signUpImage = base64Encode(bytes);
    notifyListeners();
  }

  resetImage() async {
    signUpImage = selectedImage;
    notifyListeners();
  }
}
