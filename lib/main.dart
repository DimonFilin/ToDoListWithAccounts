import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/auth/auth_page.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/add_note_screen.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/home.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/login.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/task_widget.dart';

import 'auth/main_page.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Home_Screen(),
    );
  }
}
