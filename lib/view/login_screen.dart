import 'package:email_validator/email_validator.dart';
import 'package:fire_base_first/controller/home_page_provider.dart';
import 'package:fire_base_first/view/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("User Login/Registration"),
          ),
          body: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'User Name'),
                            controller: _userName,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Password'),
                            obscureText: true,
                            controller: _password,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await context.read<AuthProvider>()
                                      .signIn(_userName.text.toString(),
                                      _password.text.toString(), context);
                                }
                              },
                              child: const Text("Login")),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    const Text('Dont have an account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                        },
                        child: const Text("Sign Up")),
                  ],
                ),
              ),
            ),
          )),
    );
  }

}
