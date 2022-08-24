import 'package:email_validator/email_validator.dart';
import 'package:fire_base_first/view/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'E-Mail'),
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
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await signUp().then((value) =>ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin:
                                                      const EdgeInsets.all(20),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  elevation: 25,
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    textAlign: TextAlign.center,
                                                    value.toString(),
                                                  ))))
                                    .then((value) => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const StartPage()),
                                            (route) => false))
                                    .onError((error, stackTrace) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin:
                                                    const EdgeInsets.all(20),
                                                duration:
                                                    const Duration(seconds: 2),
                                                elevation: 25,
                                                backgroundColor: const Color.fromARGB(255, 255, 2, 2),
                                                content: Text(
                                                  textAlign: TextAlign.center,
                                                  error.toString(),
                                                ))));
                              }
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

  Future<String> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _userName.text.trim(), password: _password.text.trim());
      return Future.value('Registered Successfully');
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }
}
