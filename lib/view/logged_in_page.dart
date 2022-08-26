import 'package:fire_base_first/controller/logged_in_provider.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:fire_base_first/view/login_screen.dart';
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
          body: FutureBuilder(
        future: Provider.of<LoggedInProv>(context, listen: false)
            .getUserDetails(user!.email.toString()),
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Errr occured'));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Logged in as ${snapshot.data!.name}")),
                Text("Last name ${snapshot.data!.lastName}"),
                Text("Profession ${snapshot.data!.profession}"),
                
                
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()),
                              (route) => false));
                    },
                    child: const Text("Log Out")),
              ],
            );
          }
        },
      ))),
    );
  }
}
