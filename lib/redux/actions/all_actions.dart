import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app/app.dart';
import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_filter.dart';
import 'package:mynotes/repositories/notes_repository.dart';

import '../app_state_store.dart';

class LoadAction extends ReduxAction<AppState> {
  LoadAction();

  @override
  Future<AppState> reduce() async {
    var repository = getIt<NotesRepository>();
    var categories = await repository.fetchCategories();
    var selectedCategory = categories[0]; // TODO read from settings
    var notes = await repository.fetchNotes(selectedCategory.id);

    var filter = NoteFilter(category: selectedCategory, noteList: notes);
    return state.copy(categories: categories, noteFilter: filter);
  }
}

class AddAction extends ReduxAction<AppState> {
  final String title;
  final String contents;

  AddAction({@required this.title, @required this.contents});

  @override
  Future<AppState> reduce() async {
    var repository = getIt<NotesRepository>();
    var selectedCategoryId = state.noteFilter.category.id;

    await repository.addNote(selectedCategoryId,
        NoteContents(title: title, contents: contents, archived: false));

    var notes = await repository.fetchNotes(selectedCategoryId);
    var filter = state.noteFilter.copy(noteList: notes);
    return state.copy(noteFilter: filter);
  }
}

class RemoveAction extends ReduxAction<AppState> {
  final String id;

  RemoveAction({@required this.id});

  @override
  Future<AppState> reduce() async {
    var repository = getIt<NotesRepository>();
    var selectedCategoryId = state.noteFilter.category.id;

    await repository.removeNote(selectedCategoryId, id);

    var notes = await repository.fetchNotes(selectedCategoryId);
    var filter = state.noteFilter.copy(noteList: notes);
    return state.copy(noteFilter: filter);
  }
}

class FilterAction extends ReduxAction<AppState> {
  final String categoryId;

  FilterAction({@required this.categoryId});

  @override
  Future<AppState> reduce() async {
    var repository = getIt<NotesRepository>();
    var notes = await repository.fetchNotes(categoryId);
    var filter = NoteFilter(
        category: state.categories.firstWhere((x) => x.id == categoryId),
        noteList: notes);
    return state.copy(noteFilter: filter);
  }
}

class ArchiveAction extends ReduxAction<AppState> {
  final String id;
  final bool archive;

  ArchiveAction({@required this.id, @required this.archive});

  @override
  Future<AppState> reduce() async {
    var repository = getIt<NotesRepository>();
    var selectedCategoryId = state.noteFilter.category.id;

    await repository.archiveNote(selectedCategoryId, id, archive);

    var notes = await repository.fetchNotes(selectedCategoryId);
    var filter = state.noteFilter.copy(noteList: notes);
    return state.copy(noteFilter: filter);
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
    var repository = getIt<NotesRepository>();
    var selectedCategoryId = state.noteFilter.category.id;

    await repository.updateNote(selectedCategoryId, id,
        NoteContents(title: title, contents: contents, archived: false));

    var notes = await repository.fetchNotes(selectedCategoryId);
    var filter = state.noteFilter.copy(noteList: notes);
    return state.copy(noteFilter: filter);
  }
}
