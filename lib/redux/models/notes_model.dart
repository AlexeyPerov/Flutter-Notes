import 'dart:ui';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/redux/actions/all_actions.dart';
import 'package:mynotes/redux/models/note_category.dart';
import 'package:mynotes/redux/models/note_filter.dart';

import '../app_state_store.dart';

class NotesModel extends BaseModel<AppState> {
  NotesModel();

  List<NoteCategory> categories;
  NoteFilter noteFilter;
    
  VoidCallback onLoad;
  Function(String, String) onCreate;
  Function(String, String, String) onUpdate;
  Function(String) onFilter;
  Function(String) onRemove;
  Function(String, bool) onArchive;

  NotesModel.build({
    @required this.categories,
    @required this.noteFilter,
    @required this.onLoad,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.onFilter,
    @required this.onRemove,
    @required this.onArchive
  }) : super(equals: [categories, noteFilter]);

  @override
  NotesModel fromStore() => NotesModel.build(
        categories: state.categories,
        noteFilter: state.noteFilter,
        onLoad: () => dispatch(LoadAction()),
        onCreate: (title, contents) =>
            dispatch(AddAction(title: title, contents: contents)),
        onUpdate: (id, title, contents) =>
            dispatch(UpdateAction(id: id, title: title, contents: contents)),
        onRemove: (id) => dispatch(RemoveAction(id: id)),
        onFilter: (categoryId) => dispatch(FilterAction(categoryId: categoryId)),
        onArchive: (id, archive) =>
            dispatch(ArchiveAction(id: id, archive: archive))
      );
}
