import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.controller,
      this.focusNode,
      required this.hintText,
      required this.icon,
      required this.checkfunction,
      this.maxlines = 1});

  final controller;
  final focusNode;
  final String hintText;
  final IconData icon;
  final int maxlines;
  final String Function(String) checkfunction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String ReturnMessage = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: TextField(
              onChanged: (String text) {
                setState(() {
                  ReturnMessage = widget.checkfunction(text);
                  debugPrint(ReturnMessage);
                });
              },
              maxLines: widget.maxlines,
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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          if (ReturnMessage.isNotEmpty)
            Text(
              //Show text if there is any problem with text
              ReturnMessage,
              style: TextStyle(color: Colors.red, fontSize: 12),
            )
        ],
      ),
    );
  }
}
