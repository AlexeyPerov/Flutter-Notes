import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_category.dart';
import 'package:mynotes/common/utilities/map_extensions.dart';

import 'notes_repository.dart';

class FirestoreNotesRepository extends NotesRepository {
  FirebaseApp _firebaseApp;

  FirebaseFirestore _provider;
  DocumentReference _user;

  @override
  Future initialize() async {
    _firebaseApp = await Firebase.initializeApp();

    _provider = FirebaseFirestore.instance;
    var users = _provider.collection('users');
    _user = users.doc("default"); // that's a stub
  }

  @override
  Future addCategory(String name) async {
    var categories = _user.collection("categories");
    await categories.add({'name': name});
  }

  @override
  Future addNote(String categoryId, NoteContents noteContents) async {
    var category = _user.collection("categories").doc(categoryId);

    await category.collection("notes").add({
      'title': noteContents.title,
      'contents': noteContents.contents,
      'archived': false
    });
  }

  @override
  Future archiveNote(String categoryId, String noteId, bool archive) async {
    var category = _user.collection("categories").doc(categoryId);
    var note = category.collection("notes").doc(noteId);

    await note.set({'archived': archive},
        SetOptions(merge: true));
  }

  @override
  Future<List<NoteCategory>> fetchCategories() async {
    var categories = await _user.collection("categories").get();

    var result = List<NoteCategory>.empty(growable: true);

    for (var document in categories.docs) {
      result.add(NoteCategory(
          id: document.id,
          name: document.data().getValueOrDefault('name', '')));
    }

    return result;
  }

  @override
  Future<List<Note>> fetchNotes(String categoryId) async {
    var category = _user.collection("categories").doc(categoryId);

    var notes = await category.collection('notes').get();

    var result = List<Note>.empty(growable: true);

    for (var document in notes.docs) {
      result.add(Note(
          id: document.id,
          title: document.data().getValueOrDefault('title', ''),
          contents: document.data().getValueOrDefault('contents', ''),
          archived: document.data().getValueOrDefault('archived', false)));
    }

    return result;
  }

  @override
  Future removeNote(String categoryId, String noteId) async {
    var category = _user.collection("categories").doc(categoryId);
    await category.collection('notes').doc(noteId).delete();
  }

  @override
  Future updateNote(
      String categoryId, String noteId, NoteContents noteContents) async {
    var category = _user.collection("categories").doc(categoryId);
    var note = category.collection("notes").doc(noteId);

    await note.set({
      'title': noteContents.title,
      'contents': noteContents.contents,
      'archived': noteContents.archived
    });
  }
}
