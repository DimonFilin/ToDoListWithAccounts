import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/add_note.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/stream_node.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool show = true;
  String _selectedSort = '1';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          shadowColor: Colors.black,
          actions: [
            Text("Sort "),
            DropdownButton<String>(
              value: _selectedSort,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSort = newValue!;

                });
              },
              items: [
                DropdownMenuItem(
                  value: '1',
                  child: Text("by Name (A-Z)"),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text("by Name (Z-A)"),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text("by Time"),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text("by Is Done"),

                ),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ]),
      backgroundColor: Colors.green.shade50,
      floatingActionButton: Visibility(
        visible: show, // If user scrolls down -> don't show this button
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddNote_Screen()));
          },
          backgroundColor: Colors.green,
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        // Catch Scroll
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            // If user scroll up
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {
            // If user scroll down
            setState(() {
              show = false;
            });
          }
          return true;
        },
        child: StreamNode(sortType: _selectedSort),
      ),   //Text("Is Done", style: TextStyle( fontSize: 16, color: Colors.grey.shade500),),//Under are notes with field IsDone true

    );
  }
}