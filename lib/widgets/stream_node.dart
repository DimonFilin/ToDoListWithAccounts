import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/data/api/firestore.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/widgets/task_widget.dart';

import '../model/notes_model.dart';

class StreamNode extends StatefulWidget {
  final String sortType;

  StreamNode({super.key, required this.sortType});

  @override
  State<StreamNode> createState() => _StreamNodeState();
}

class _StreamNodeState extends State<StreamNode> {
  final ValueNotifier<List<Note>> _sortedNotes = ValueNotifier<List<Note>>([]);

  void _sortItems(List<dynamic> notes) {
    switch (widget.sortType) {
      case '1':
        notes.sort((a, b) => a.title.compareTo(b.title));
        break;
      case '2':
        notes.sort((a, b) => b.title.compareTo(a.title));
        break;
      case '3':
        notes.sort((a, b) => a.timetodo.compareTo(b.timetodo));
        break;
      case '4':
        notes.sort((a, b) => a.isDone.toString().compareTo(b.isDone.toString()));
        break;
    }
    _sortedNotes.value = List.from(notes);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FireStore_Database().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final noteslist = FireStore_Database().GetNotes(snapshot);
          _sortItems(noteslist);

          return ValueListenableBuilder<List<Note>>(
            valueListenable: _sortedNotes,
            builder: (context, sortedNotes, _) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final note = sortedNotes[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      FireStore_Database().DeleteNote(note.id);
                    },
                    child: Task_Widget(note),
                  );
                },
                itemCount: sortedNotes.length,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _sortedNotes.dispose();
    super.dispose();
  }
}