import 'dart:ui';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/redux/actions/all_actions.dart';

import '../app_state_store.dart';
import 'note.dart';

class NotesModel extends BaseModel<AppState> {
  NotesModel();

  List<Note> noteList;
  VoidCallback onQuery;
  Function(String, String) onCreate;
  Function(String, String, String) onUpdate;
  Function(String) onRemove;
  Function(String, bool) onArchive;
  VoidCallback onPop;

  NotesModel.build({
    @required this.noteList,
    @required this.onQuery,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.onRemove,
    @required this.onArchive,
    @required this.onPop,
  }) : super(equals: [noteList]);

  @override
  NotesModel fromStore() => NotesModel.build(
        noteList: state.noteList,
        onQuery: () => dispatch(QueryAllAction()),
        onCreate: (title, contents) =>
            dispatch(AddAction(title: title, contents: contents)),
        onUpdate: (id, title, contents) =>
            dispatch(UpdateAction(id: id, title: title, contents: contents)),
        onRemove: (id) => dispatch(RemoveAction(id: id)),
        onArchive: (id, archive) =>
            dispatch(ArchiveAction(id: id, archive: archive)),
        onPop: () => dispatch(NavigateAction.pop()),
      );
}
