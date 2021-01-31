import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app/app.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/redux/app_state_store.dart';
import 'package:mynotes/screens/notes/notes_connector.dart';
import 'package:mynotes/common/utilities/routing/routing_extensions.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  final Future _appInitialization;

  AppWidget() : _appInitialization = App.initializeApp();

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: theme(),
      onGenerateRoute: _generateRoute,
    ),
  );

  FutureBuilder _redirectOnAppInit(RouteToWidget routeTo) {
    return FutureBuilder(
      future: _appInitialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(); // TODO error screen
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return routeTo();
        }

        return Container(); // TODO splash screen
      },
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    var routingData = settings.name.getRoutingData;
    switch (routingData.route) {
      case '/new':
        // TODO
        break;
    }

    return MaterialPageRoute(
      builder: (context) => _redirectOnAppInit(() => NotesConnector()),
    );
  }
}

typedef Widget RouteToWidget();