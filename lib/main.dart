import 'package:firestore_practice/bloc_provider.dart';
import 'package:firestore_practice/src/home_bloc.dart';
import 'package:flutter/material.dart';

import 'package:firestore_practice/src/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: HomeBloc(),
        child: FirestoreCRUDPage(),
      )
    );
  }
}
