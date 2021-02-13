import 'dart:async';

import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_category.dart';

abstract class NotesRepository {
  Future initialize();
  Future<List<NoteCategory>> fetchCategories();
  Future addCategory(String name);
  Future<List<Note>> fetchNotes(String categoryId);
  Future removeNote(String categoryId, String noteId);
  Future archiveNote(String categoryId, String noteId, bool archive);
  Future updateNote(String categoryId, String noteId, NoteContents note);
  Future addNote(String categoryId, NoteContents note);
}
