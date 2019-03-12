import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String comment;

Widget makeComments() {
  return TextFormField(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'comment',
      fillColor: Colors.grey[300],
      filled: true,
    ),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
    },
    onSaved: (value) => comment = value,
  );
}


class DB {
  final db = Firestore.instance;

  Stream<QuerySnapshot> initStream(){
    return db.collection('CRUD').snapshots();
  }
  Future<String> createData(String name) async {
    DocumentReference ref = await db.collection('CRUD').add({'name' : '$name', 'todo': randomTodo()});
    print(ref.documentID);
    print(ref.documentID);

  }

  Future<void> readData(String id) async {
    DocumentSnapshot snapshot = await db.collection('CRUD').document(id).get();
    print(snapshot.data['name']);
  }

  Future<void> updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).updateData({'todo' : makeComments()});
  }

  Future<void> deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).delete();
  }


  // Should not be inside here but probably inside a todoObject
  String randomTodo() {
    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'Like and subscribe 💩';
        break;
      case 2:
        todo = 'Twitter @robertbrunhage 🤣';
        break;
      case 3:
        todo = 'Patreon in the description 🤗';
        break;
      default:
        todo = 'Leave a comment 🤓';
        break;
    }
    return todo;
  }

}

DB db = DB();
