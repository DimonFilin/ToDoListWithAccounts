import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/custom_text_field.dart';

class AddNote_Screen extends StatefulWidget {
  const AddNote_Screen({super.key});

  @override
  State<AddNote_Screen> createState() => _AddNote_ScreenState();
}

class _AddNote_ScreenState extends State<AddNote_Screen> {
  final title = TextEditingController();
  final subtitle = TextEditingController();

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
                  FireStore_Database().AddNote(title.text, subtitle.text);
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
