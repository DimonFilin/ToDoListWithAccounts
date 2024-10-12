import 'package:flutter/material.dart';

Widget logo() {//Displays picture of company Logo
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
