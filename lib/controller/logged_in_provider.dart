import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoggedInProv extends ChangeNotifier {
  Stream userDataStream(User user) async* {
    var document =
        FirebaseFirestore.instance.collection('users').doc(user.email).snapshots();
    yield document;
  }

  // getUser() {
  //   var collection = FirebaseFirestore.instance
  //       .collection('users')
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot element) {
  //       print(element.data());
  //     });
  //   });
  // }

  Future<UserModel> getUserDetails(String email) async {
    var doc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return (UserModel.fromMap(doc));
  }
}
