import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/custom_text_field.dart';

import '../data/check/check_data_in_customtextfield.dart';

class AddNote_Screen extends StatefulWidget {
  const AddNote_Screen({super.key});

  @override
  State<AddNote_Screen> createState() => _AddNote_ScreenState();
}

class _AddNote_ScreenState extends State<AddNote_Screen> {
  //Controllers for text fields to ger data from them
  final title = TextEditingController();
  final subtitle = TextEditingController();

  //FocusNodes to highlighting text fields
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  DateTime? _selectedDateTime;
  String ReturnMessage = "";

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
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      //Initializing a focus node, when widget is created
      setState(() {});
    });
    _focusNode2.addListener(() {
      //Another one
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        //To get back without creating a new note
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
          //Main fields
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
                  ReturnMessage = "";
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                //Button to save note
                onPressed: () {
                  if (_selectedDateTime == null) {
                    setState(() {
                      ReturnMessage = "Please fill up the time";
                      debugPrint(ReturnMessage);
                    });
                  } else {
                    if (title.text.isEmpty) {
                      setState(() {
                        ReturnMessage = "Please fill up the title";
                        debugPrint(ReturnMessage);
                      });
                    } else {
                      if (subtitle.text.isEmpty) {
                        setState(() {
                          ReturnMessage = "Please fill up the subtitle";
                          debugPrint(ReturnMessage);
                        });
                      } else {
                        FireStore_Database().AddNote(
                            title.text, subtitle.text, _selectedDateTime!);
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: Text("Save note"),
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
