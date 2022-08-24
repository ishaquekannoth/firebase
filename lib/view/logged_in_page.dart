import 'package:fire_base_first/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  LoggedIn({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
          body: FutureBuilder(
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("Logged in as ${user!.email}")),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LogInScreen()),
                                    (route) => false));
                          },
                          child: const Text("Log Out")),
                    ],
                  ),
      ))),
    );
  }
}
