import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/auth_data.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/check/check_data_in_customtextfield.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/custom_text_field.dart';

import '../ui/small_logo.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;

  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  //Controllers to get info from text fields
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  //Nodes to highlighting
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              logo(),
              SizedBox(height: 50),
              CustomTextField(
                controller: email,
                focusNode: _focusNode1,
                hintText: "Email",
                icon: Icons.email,
                checkfunction: EmailCheck,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: password,
                focusNode: _focusNode2,
                hintText: "Password",
                icon: Icons.password,
                checkfunction: PasswordCheck,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: repeatPassword,
                focusNode: _focusNode3,
                hintText: "Confirm Password",
                icon: Icons.password,
                checkfunction: PasswordCheck,
              ),
              SizedBox(
                height: 20,
              ),
              HaveAccountText(),
              SizedBox(height: 8),
              SignUpButton()
            ],
          ),
        ),
      ),
    );
  }


  Widget SignUpButton() {//Button to make new account in Firestore
    return GestureDetector(
        onTap: () {
          AuthenticationRemote()
              .register(email.text, password.text, repeatPassword.text);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Text('Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            )));
  }

  Widget HaveAccountText() {//Text with ling to Login page
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        ),
        GestureDetector(
          onTap: widget.show,
          child: Text(
            "LogIn",
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
