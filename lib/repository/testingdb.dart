import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


class crudMedthods {

  Future<void> addData(carData) async {
      Firestore.instance.collection('CRUD').add(carData).catchError((e) {
        print(e);
      });
      //Using Transactions
      // Firestore.instance.runTransaction((Transaction crudTransaction) async {
      //   CollectionReference reference =
      //       await Firestore.instance.collection('testcrud');

      //   reference.add(carData);
      // });
  }

  getData() async {
    return await Firestore.instance.collection('CRUD').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('CRUD')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('CRUD')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}