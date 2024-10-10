import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/task_widget.dart';

class StreamNode extends StatelessWidget {
  StreamNode(this.done,{super.key});
  bool done;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FireStore_Database().stream(done),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final noteslist = FireStore_Database().GetNotes(snapshot);
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final note = noteslist[index];
                  return Dismissible(key: UniqueKey() , onDismissed: (direction) {
                    FireStore_Database().DeleteNote(note.id);
                  },child: Task_Widget(note));
                },
                itemCount: noteslist.length,
              );
            }));
  }
}
