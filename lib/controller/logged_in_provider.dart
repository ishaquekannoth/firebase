import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class LoggedInProv extends ChangeNotifier {
  Future<UserModel> getUserDetails(String email) async {
    var doc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return (UserModel.fromMap(doc));
  }
}
