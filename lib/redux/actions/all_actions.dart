import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/redux/models/note.dart';

import '../app_state_store.dart';

class QueryAllAction extends ReduxAction<AppState> {
  QueryAllAction();

  @override
  Future<AppState> reduce() async {
    List<Note> noteList = [
      Note(id: '1', title: 'title', contents: 'contents', archived: false),
      Note(id: '2', title: 'title 2', contents: 'contents 2', archived: false)
    ];

    return state.copy(noteList: noteList);
  }
}

class AddAction extends ReduxAction<AppState> {
  final String title;
  final String contents;

  AddAction({@required this.title, @required this.contents});

  @override
  Future<AppState> reduce() async {
    var noteList = List<Note>.from(state.noteList);

    var id =
        state.noteList.length > 0 ? int.parse(state.noteList.last.id) + 1 : 1;

    noteList.add(Note(
        id: id.toString(), title: title, contents: contents, archived: false));

    return state.copy(noteList: noteList);
  }
}

class RemoveAction extends ReduxAction<AppState> {
  final String id;

  RemoveAction({@required this.id});

  @override
  Future<AppState> reduce() async {
    var noteList = List<Note>.from(state.noteList);
    noteList.removeWhere((x) => x.id == id);
    return state.copy(noteList: noteList);
  }
}

class ArchiveAction extends ReduxAction<AppState> {
  final String id;
  final bool archive;

  ArchiveAction({@required this.id, @required this.archive});

  @override
  Future<AppState> reduce() async {
    var noteList = state.noteList
        .map<Note>((x) => x.id == this.id
            ? x = x.copy(
                id: x.id,
                title: x.title,
                contents: x.contents,
                archived: this.archive)
            : x)
        .toList();

    return state.copy(noteList: noteList);
  }
}

class UpdateAction extends ReduxAction<AppState> {
  final String id;
  final String title;
  final String contents;

  UpdateAction(
      {@required this.id, @required this.title, @required this.contents});

  @override
  Future<AppState> reduce() async {
    var noteList = state.noteList
        .map<Note>((x) => x.id == this.id
            ? x = x.copy(
                id: x.id,
                title: this.title,
                contents: this.contents,
                archived: x.archived)
            : x)
        .toList();

    return state.copy(noteList: noteList);
  }
}
