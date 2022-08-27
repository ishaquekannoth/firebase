import 'dart:convert';
import 'package:fire_base_first/controller/update_provider.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:fire_base_first/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController(text: 'Name');
  final lastNameController = TextEditingController(text: 'Last name');
  final professionController = TextEditingController(text: 'Profession');
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: StreamBuilder(
          stream: Provider.of<UpdateProvider>(context).userDataStream(user!),
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
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Name'),
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Last Name'),
                    ),
                    TextFormField(
                      controller: professionController,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Profession'),
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
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () async {
                              final data = UserModel(
                                  email: user!.email.toString(),
                                  lastName: lastNameController.text,
                                  name: nameController.text,
                                  profession: professionController.text,
                                  image: snapshot.data!.image);
                              Provider.of<UpdateProvider>(context,
                                      listen: false)
                                  .update(context, data)
                                  .then((value) => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              LogInScreen())));
                            },
                            child: const Text("Update")),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    ));
  }
}
