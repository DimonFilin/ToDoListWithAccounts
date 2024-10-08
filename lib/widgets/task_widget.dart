import 'package:flutter/material.dart';

class Task_Widget extends StatefulWidget {
  const Task_Widget({super.key});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical:  15),
            child: Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  ),
          )),
    );
  }
}
