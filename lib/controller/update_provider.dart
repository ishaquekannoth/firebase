import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProvider extends ChangeNotifier {
  String? signedUpImage;
  Stream<UserModel> userDataStream(User user) async* {
    var document = FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .snapshots()
        .map((data) => UserModel.fromMap(data));
    yield* document;
  }

  Future<UserModel> getUserDetailsFuture(String email) async {
    var doc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return (UserModel.fromMap(doc));
  }

  Future<void> pickimage(String email) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(image!.path).readAsBytesSync();
    signedUpImage = base64Encode(bytes);
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .update({'image': signedUpImage});

    notifyListeners();
  }

  Future<void> update(BuildContext context, UserModel data) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(data.email)
          .set(data.toMapped())
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  duration: Duration(seconds: 2),
                  elevation: 25,
                  backgroundColor: Color.fromARGB(255, 5, 236, 36),
                  content: Text('Updated Successfully'))));
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

  setImage(String image) async {
    signedUpImage = image;
    print('Image set');
    notifyListeners();
  }
}
