import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoggedInProv extends ChangeNotifier {

  getUserDetails(String email) async {
    var doc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    print(UserModel.fromMap(doc).toMapped().toString());
  }
}
