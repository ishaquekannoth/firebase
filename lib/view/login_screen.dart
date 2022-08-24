import 'package:email_validator/email_validator.dart';
import 'package:fire_base_first/view/logged_in_page.dart';
import 'package:fire_base_first/view/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                                  await signIn(context).then((value) =>ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin:
                                                      const EdgeInsets.all(20),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  elevation: 25,
                                                  backgroundColor: const Color.fromARGB(255, 255, 2, 2),
                                                  content: Text(
                                                    textAlign: TextAlign.center,
                                                    value.toString(),
                                                  ))))
                                      .then((value) => Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoggedIn()),
                                              (route) => false))
                                      .onError((error, stackTrace) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin:
                                                      const EdgeInsets.all(20),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  elevation: 25,
                                                  backgroundColor: const Color.fromARGB(255, 255, 2, 2),
                                                  content: Text(
                                                    textAlign: TextAlign.center,
                                                    error.toString(),
                                                  ))));
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
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => SignUp()),
                              (route) => false);
                        },
                        child: const Text("Sign Up")),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<String> signIn(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userName.text.trim(), password: _password.text.trim());
      return Future.value('SuccessFully logged in') ;
    } on FirebaseAuthException catch (e) {
      return Future.error( e.message!);
    }
  }
}
