import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

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
                  icon: Icons.email),
              SizedBox(height: 10),
              CustomTextField(
                  controller: password,
                  focusNode: _focusNode2,
                  hintText: "Password",
                  icon: Icons.password),
              SizedBox(height: 10),
              CustomTextField(
                  controller: repeatPassword,
                  focusNode: _focusNode3,
                  hintText: "Confirm Password",
                  icon: Icons.password),
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

  Padding logo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/logo.png'))),
      ),
    );
  }

  Widget SignUpButton() {
    return GestureDetector(
        onTap: () {
      AuthenticationRemote().register(email.text, password.text, repeatPassword.text);
    },
    child:   Padding(
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

  Widget HaveAccountText() {
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

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.controller,
      this.focusNode,
      required this.hintText,
      required this.icon});

  final controller;
  final focusNode;
  final String hintText;
  final IconData icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: widget.focusNode.hasFocus
                  ? Colors.green
                  : Colors.grey.shade100,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: Colors.grey.shade100, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green, width: 2.0)),
          ),
        ),
      ),
    );
  }
}
