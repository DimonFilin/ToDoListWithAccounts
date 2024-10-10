import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_for_flutter_krainet_vacancy/model/notes_model.dart';
import 'package:uuid/uuid.dart';

class FireStore_Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return true;
    }
  }

  Future<bool> AddNote(String title, String subtitle) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();
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
        'time': '${data.hour}:${data.minute}'
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return true;
    }
  }

  List GetNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          data['time'],
          data['title'],
          data['isDone'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes').where('isDone', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> IsDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> UpdateNote(String uuid, String title, String subtitle) async {
    //DateTime data = new DateTime.now(); Если надо обнавлять время
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'title': title, 'subtitle': subtitle});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
  Future<bool> Update_Note(
      String uuid, String title, String subtitle) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> DeleteNote(String uuid) async{
    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
