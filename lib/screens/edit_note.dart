import 'package:flutter/material.dart';

import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/custom_text_field.dart';

import '../data/api/firestore.dart';
import '../data/check/check_data_in_customtextfield.dart';
import '../model/notes_model.dart';

class EditNote_Screen extends StatefulWidget {
  EditNote_Screen(this._note, {super.key});

  Note _note;

  @override
  State<EditNote_Screen> createState() => _EditNote_ScreenState();
}

class _EditNote_ScreenState extends State<EditNote_Screen> {
  //Controllers to get and set text in fields
  TextEditingController? title;
  TextEditingController? subtitle;

  //Focus nodes for proper highlighting
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  //Date to select a new dart
  DateTime? _selectedDateTime;
  String ReturnMessage = "";

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    title = TextEditingController(
        text: widget._note
            .title); //Initialization of the controller with text that was previously entered
    subtitle = TextEditingController(text: widget._note.subtitle); //Another one
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        //Fast way to get out without changing note fields
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
          //Main text fields
          CustomTextField(
            hintText: "Title",
            icon: Icons.title,
            controller: title,
            focusNode: _focusNode1,
            checkfunction: TitleCheck,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            hintText: "SubTitle",
            icon: Icons.title,
            controller: subtitle,
            focusNode: _focusNode2,
            maxlines: 2,
            checkfunction: SubTitleCheck,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                //Button to save note
                onPressed: () {
                  _selectDateTime(context);
                  setState(() {
                    ReturnMessage = "";
                  });
                },
                child: Text('Select Date and Time'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(190, 48)),
              ),
              if (ReturnMessage.isNotEmpty)
                Text(
                  //Show text if there is any problem with text
                  ReturnMessage,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                //Button to edit note from Firestore
                onPressed: () {
                  if (_selectedDateTime != null) {
                    FireStore_Database().UpdateNote(widget._note.id,
                        title!.text, subtitle!.text, _selectedDateTime!);
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      ReturnMessage = "Please select a date and time";
                      debugPrint(ReturnMessage);
                    });
                  }
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
