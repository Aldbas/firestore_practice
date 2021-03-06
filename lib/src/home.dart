import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_bloc.dart';
import 'package:firestore_practice/bloc_provider.dart';
import 'package:firestore_practice/repository/db.dart';

class FirestoreCRUDPage extends StatefulWidget {
  @override
  FirestoreCRUDPageState createState() {
    return FirestoreCRUDPageState();
  }
}

class FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String comment;

  Card buildItem(DocumentSnapshot doc, HomeBloc bloc,) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'name: ${doc.data['name']}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'todo: ${doc.data['todo']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => db.updateData(doc),
                  child: Text(
                      'Update todo', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => bloc.deleteData(doc),
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                buildTextFormField(),
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () => createData(bloc),
                child: Text('Create', style: TextStyle(color: Colors.white)),
                color: Colors.green,
              ),
              StreamBuilder<String>(
                  stream: bloc.outId,
                  initialData: null,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      onPressed: snapshot.data != null ? bloc.readData : null,
                      child: Text(
                          'Read', style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                    );
                  }
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bloc.outFirestore,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) =>
                    buildItem(doc, bloc)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  void createData(HomeBloc bloc) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bloc.createData(name);
    }
  }
}
