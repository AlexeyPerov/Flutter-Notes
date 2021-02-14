import 'dart:async';

import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_category.dart';

import 'notes_repository.dart';

class MockNotesRepository extends NotesRepository {
  int noteId = 3;
  int categoryId = 2;

  List<NoteCategory> categories = [
    NoteCategory(id: '0', name: 'Category 1'),
    NoteCategory(id: '1', name: 'Category 2'),
    NoteCategory(id: '2', name: 'Category 3')
  ];

  var notes = <String, List<Note>>{
    '0': [
      Note(
          id: '0',
          title: 'Suspendisse sed nisi lacus sed viverra tellus',
          contents: 'Massa placerat duis ultricies lacus. Enim nec dui nunc mattis',
          archived: false),
      Note(
          id: '1',
          title: 'Excepteur sint occaecat cupidatat non proident',
          contents: 'sunt in culpa qui officia deserunt mollit anim id est laborum',
          archived: false),
      Note(
          id: '4',
          title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
              ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
          contents: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco '
              'laboris nisi ut aliquip ex ea commodo consequat',
          archived: false),
      Note(
          id: '5',
          title: 'Duis aute irure dolor in reprehenderit ',
          contents: 'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
          archived: false),
      Note(
          id: '6',
          title: 'At varius vel pharetra vel turpis nunc eget lorem',
          contents: 'Dolor morbi non arcu risus quis varius.',
          archived: true)
    ],
    '1': [
      Note(
          id: '3',
          title: 'Do or learn something 3',
          contents: 'and don\'t forget to reopen it later',
          archived: false)
    ],
    '2': []
  };

  @override
  Future initialize() async {
    await Future.delayed(new Duration(milliseconds: 300));
  }

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