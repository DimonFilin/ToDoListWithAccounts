import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/login.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/signUp.dart';

class Auth_Page extends StatefulWidget {
  const Auth_Page({super.key});

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {

  bool a = true;
  //Changing screen if need
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(a) return LoginScreen(to);
    else return SignUp_Screen(to);
  }
}
