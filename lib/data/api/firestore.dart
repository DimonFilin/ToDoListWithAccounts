import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/model/notes_model.dart';
import 'package:uuid/uuid.dart';

//Basic class for working with Firebase on Notes
class FireStore_Database {

  //Main Firestore instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Method for creating a new user
  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {//In case, there is some error, when creating a new user
      debugPrint(e.toString());
      return true;
    }
  }

  //Make new Note and add it to Firestore
  Future<bool> AddNote(String title, String subtitle, DateTime data2) async {
    try {
      var uuid = Uuid().v4();//New id for every note
      DateTime data = new DateTime.now();//Take now time
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'isDone': false,
        'time': '${data.year}:${data.month}:${data.day}:${data.hour}:${data.minute}',
        'timetodo': '${data2.year}:${data2.month}:${data2.day}:${data2.hour}:${data2.minute}',

      });
      return true;
    } catch (e) {//In case, there is some error, creating a new note
      debugPrint(e.toString());
      return true;
    }
  }

  //Get Notes from Firestore
  List GetNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['title'],
          data['time'],
          data['subtitle'],
          data['isDone'],
          data['timetodo']
        );
      }).toList();
      return notesList;
    } catch (e) {//In case, there is some error, getting notes
      print(e);
      return [];
    }
  }

  //Stream to get notes
  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .snapshots();
  }

  //Change Note field IsDone in Firestore
  Future<bool> IsDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {//In case, there is some error, changing IsDone
      print(e);
      return true;
    }
  }

  //Update notes in Firestore
  Future<bool> UpdateNote(String uuid, String title, String subtitle, DateTime data2) async {
    //DateTime data = new DateTime.now(); If need to update time  'time': '${data.hour}:${data.minute}',
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'title': title, 'subtitle': subtitle, 'timetodo': '${data2.year}:${data2.month}:${data2.day}:${data2.hour}:${data2.minute}',});
      return true;
    } catch (e) {//In case, there is some error, when updating notes
      print(e);
      return true;
    }
  }

  //Deleting notes in Firestore
  Future<bool> DeleteNote(String uuid) async{
    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).delete();
      return true;
    } catch (e) {//In case, there is some error, when deleting a note
      print(e);
      return true;
    }
  }
}
