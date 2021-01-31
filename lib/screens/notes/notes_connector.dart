import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:mynotes/redux/app_state_store.dart';
import 'package:mynotes/redux/models/notes_model.dart';

import 'notes_screen.dart';

class NotesConnector extends StatelessWidget {
  NotesConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NotesModel>(
      model: NotesModel(),
      onInitialBuild: (viewModel) => viewModel.onLoad(),
      builder: (BuildContext context, NotesModel viewModel) => NotesScreen(
        categories: viewModel.categories,
        noteFilter: viewModel.noteFilter,
        onQuery: viewModel.onLoad,
        onAddCategory: viewModel.onAddCategory,
        onAddNote: viewModel.onAddNote,
        onUpdate: viewModel.onUpdate,
        onFilter: viewModel.onFilter,
        onRemove: viewModel.onRemove,
        onArchive: viewModel.onArchive
      ),
    );
  }
}