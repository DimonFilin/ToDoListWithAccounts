import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/custom_text_field.dart';

import '../model/notes_model.dart';

class EditNote_Screen extends StatefulWidget {
  EditNote_Screen(this._note,{super.key});
  Note _note;
  @override
  State<EditNote_Screen> createState() => _EditNote_ScreenState();
}

class _EditNote_ScreenState extends State<EditNote_Screen> {
  TextEditingController? title;
  TextEditingController? subtitle;

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();



  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade200,
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.close,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: "Title",
                icon: Icons.title,
                controller: title,
                focusNode: _focusNode1,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: "SubTitle",
                  icon: Icons.title,
                  controller: subtitle,
                  focusNode: _focusNode2,
                  maxlines: 2),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FireStore_Database().UpdateNote(
                          widget._note.id, title!.text, subtitle!.text);
                      Navigator.pop(context);

                    },
                    child: Text("Save task"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: Size(190, 48)),
                  )
                ],
              )
            ],
          )),
    );
  }
}
