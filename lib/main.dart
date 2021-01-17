import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/redux/app_state_store.dart';
import 'package:mynotes/screens/notes/notes_connector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: NotesConnector()
    ),
  );
}