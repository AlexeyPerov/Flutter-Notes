import 'dart:async';

import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_category.dart';

abstract class NotesRepository {
  void initialize();
  Future<List<NoteCategory>> fetchCategories();
  Future addCategory(String name);
  Future<List<Note>> fetchNotes(String categoryId);
  Future removeNote(String categoryId, String noteId);
  Future archiveNote(String categoryId, String noteId, bool archive);
  Future updateNote(String categoryId, String noteId, NoteContents note);
  Future addNote(String categoryId, NoteContents note);
}

class InMemoryNotesRepository extends NotesRepository {
  int noteId = 3;
  int categoryId = 2;

  List<NoteCategory> categories = [
    NoteCategory(id: '0', name: 'All'),
    NoteCategory(id: '1', name: 'Job'),
    NoteCategory(id: '2', name: 'Random')
  ];

  var notes = <String, List<Note>>{
    '0': [
      Note(id: '0', title: 'title', contents: 'contents', archived: false),
      Note(id: '1', title: 'title 1', contents: 'contents 1', archived: false)
    ],
    '1': [
      Note(id: '3', title: 'title 2', contents: 'contents 2', archived: false)
    ],
    '2': []
  };

  @override
  void initialize() {}

  @override
  Future addCategory(String name) async {
    categoryId++;
    var newId = categoryId.toString();
    categories.add(NoteCategory(id: newId, name: name));
    notes[newId] = List.empty(growable: true);
    await Future.delayed(new Duration(milliseconds: 300));
  }

  @override
  Future addNote(String categoryId, NoteContents noteContents) async {
    noteId++;
    notes[categoryId].add(Note.fromContents(noteId.toString(), noteContents));
    await Future.delayed(new Duration(milliseconds: 300));
  }

  @override
  Future archiveNote(String categoryId, String noteId, bool archive) async {
    var note = notes[categoryId].firstWhere((x) => x.id == noteId);
    var newNote = note.copy(
        id: note.id,
        title: note.title,
        contents: note.contents,
        archived: archive);

    notes[categoryId].removeWhere((x) => x.id == noteId);
    notes[categoryId].add(newNote);

    await Future.delayed(new Duration(milliseconds: 300));
  }

  @override
  Future<List<NoteCategory>> fetchCategories() {
    return Future.value(categories.toList());
  }

  @override
  Future<List<Note>> fetchNotes(String categoryId) {
    return Future.value(notes[categoryId].toList());
  }

  @override
  Future removeNote(String categoryId, String noteId) async {
    notes[categoryId].removeWhere((x) => x.id == noteId);
    await Future.delayed(new Duration(milliseconds: 300));
  }

  @override
  Future updateNote(
      String categoryId, String noteId, NoteContents noteContents) async {
    var newNote = Note(
        id: noteId,
        title: noteContents.title,
        contents: noteContents.contents,
        archived: noteContents.archived);

    notes[categoryId].removeWhere((x) => x.id == noteId);
    notes[categoryId].add(newNote);

    await Future.delayed(new Duration(milliseconds: 300));
  }
}

/*class FirestoreNotesRepository extends NotesRepository {
  @override
  void initialize() {
  }
}*/
