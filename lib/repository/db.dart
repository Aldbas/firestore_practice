import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firestore_practice/src/home.dart';

DB db = DB();

class DB {
  final db = Firestore.instance;

  String get documentID => null;

  Stream<QuerySnapshot> initStream(){
    return db.collection('CRUD').snapshots();
  }
  Future<String> createData(String name) async {
    DocumentReference ref = await db.collection('CRUD').add({'name' : '$name', 'todo': 'help' });
    print(ref.documentID);

  }

  Future<void> readData(String id) async {
    DocumentSnapshot snapshot = await db.collection('CRUD').document(id).get();
    print(snapshot.data['name']);
  }
/// FIND WAYS TO UPDATE DATA THROUGH USER INPUT//////
  Future<String> updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(documentID).updateData({'todo' : doc});
  }

  Future<void> deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).delete();
  }
}


