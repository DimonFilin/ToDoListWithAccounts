import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/add_note.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/stream_node.dart';


class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      floatingActionButton: Visibility(
        visible: show,//If user scrolls down -> don't show this button
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
      body: NotificationListener<UserScrollNotification>(//Catch Scroll
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {//If user scroll up
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {//If user scroll down
            setState(() {
              show = false;
            });
          }
          return true;
        },
        child:Column(
          children: [
            StreamNode(false),
            Text("Is Done", style: TextStyle( fontSize: 16, color: Colors.grey.shade500),),//Under are notes with field IsDone true
            StreamNode(true)
          ],
        )
      ),
    );
  }
}
