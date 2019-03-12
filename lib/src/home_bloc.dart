import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_practice/bloc_provider.dart';
import 'package:firestore_practice/repository/db.dart';

class HomeBloc implements BlocBase{
  HomeBloc() {
    db.initStream().listen((data) => _inFirestore.add(data));
    // initiate stream
  }
  String id;
  final _idController = StreamController<String>();
  Stream<String> get outId => _idController.stream;
  Sink<String> get _inId => _idController.sink;

  final _firestoreController = StreamController<QuerySnapshot>();
  Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
  Sink<QuerySnapshot> get _inFirestore => _firestoreController.sink;

  @override
    void dispose() {
    _idController.close();
    _firestoreController.close();
    // TODO: implement dispose
  }
  void readData() async {
     await db.readData(id);
  }

  void updateData(DocumentSnapshot doc) async {
    db.updateData(doc);
  }

  void deleteData(DocumentSnapshot doc) async {
     await db.deleteData(doc);
  }
  void createData(String name) async {
     String id = await db.createData(name);
     this.id = id;
     _inId.add(id);

  }

}

