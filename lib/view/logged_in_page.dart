import 'dart:convert';

import 'package:fire_base_first/controller/logged_in_provider.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:fire_base_first/view/login_screen.dart';
import 'package:fire_base_first/view/update_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedIn extends StatelessWidget {
  LoggedIn({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
          body: StreamBuilder<UserModel>(
        // stream: FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user!.email)
        //     .snapshots(),
        stream: Provider.of<LoggedInProv>(context).userDataStream(user!),
        //  Provider.of<LoggedInProv>(context, listen: false)
        //     .getUserDetails(user!.email.toString()),
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Errr occured'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 35,
                      backgroundImage: MemoryImage(const Base64Decoder()
                          .convert(snapshot.data!.image!))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35)),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "First Name : ${snapshot.data!.name}",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35)),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Last name : ${snapshot.data!.lastName}",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35)),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Profession : ${snapshot.data!.profession}",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then(
                                (value) => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LogInScreen()),
                                        (route) => false));
                          },
                          child: const Text("Log Out")),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateScreen()));
                          },
                          child: const Text("Update")),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ))),
    );
  }
}
