import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/redux/app_state_store.dart';
import 'package:mynotes/screens/notes/notes_connector.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      theme: ThemeData.dark(),
      home: NotesConnector(),
      navigatorKey: navigatorKey,
    ),
  );
}