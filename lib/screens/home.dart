import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/screens/add_note_screen.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/stream_node.dart';

import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/task_widget.dart';

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
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: Visibility(
        visible: show,
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
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              show = false;
            });
          }
          return true;
        },
        child:Column(
          children: [
            StreamNode(false),
            Text("Is Done", style: TextStyle( fontSize: 16, color: Colors.grey.shade500),),
            StreamNode(true)
          ],
        )
      ),
    );
  }
}
