import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/page/auth/auth_page.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/home.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){//Show Home_Screen if user already signed in
              return Home_Screen();
            }
            else
              {//If there is no data from Firebase
                return Auth_Page();
              }
          }),
    );
  }
}
