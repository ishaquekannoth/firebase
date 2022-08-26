import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fire_base_first/controller/sign_up_sign_in.dart';
import 'package:fire_base_first/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _profession = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthProvider>().resetImage();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await context.read<AuthProvider>().pickimage();
                    },
                    child: Consumer<AuthProvider>(
                      builder: (context, value, child) => CircleAvatar(
                          radius: 35,
                          backgroundImage: MemoryImage(const Base64Decoder()
                              .convert(
                                  context.read<AuthProvider>().signUpImage))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) => EmailValidator.validate(value!)
                              ? 'Email valid'
                              : "Please enter a valid email",
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'E-Mail'),
                          controller: _userName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Invalid password";
                            }
                            return 'Passsword Valid';
                          },
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Password'),
                          obscureText: true,
                          controller: _password,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: Colors.green,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Name" : 'OK',
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'First Name'),
                          controller: _name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Enter Last Name" : 'OK',
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Last Name'),
                          controller: _lastname,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Enter Profession" : 'OK',
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Profession'),
                          controller: _profession,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final userdata = UserModel(
                                  email: _userName.text.toString(),
                                  name: _name.text.toString(),
                                  lastName: _lastname.text.toString(),
                                  profession: _profession.text.toString(),image: context.read<AuthProvider>().signUpImage);
                              await context.read<AuthProvider>().signUp(
                                  _userName.text.toString(),
                                  _password.text.toString(),
                                  context,
                                  userdata);
                            },
                            child: const Text("Sign Up"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
