import 'package:fire_base_first/controller/logged_in_provider.dart';
import 'package:fire_base_first/controller/sign_up_sign_in.dart';
import 'package:fire_base_first/controller/update_provider.dart';
import 'package:fire_base_first/view/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
         ChangeNotifierProvider(create: (context) => LoggedInProv()),
         ChangeNotifierProvider(create: (context) => UpdateProvider())
      ],
      child: MaterialApp(
        title: 'Firebase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartPage(),
      ),
    );
  }
}
