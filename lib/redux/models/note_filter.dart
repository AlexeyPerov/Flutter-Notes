import 'package:flutter/material.dart';
import 'package:mynotes/redux/models/note_category.dart';
import 'package:mynotes/redux/models/note.dart';

@immutable
class NoteFilter {
  final NoteCategory category;
  final List<Note> noteList;

  NoteFilter({this.category, this.noteList});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteFilter &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          noteList == other.noteList;

  @override
  int get hashCode => category.hashCode ^ noteList.hashCode;

  NoteFilter copy({NoteCategory category, List<Note> noteList}) => NoteFilter(
      category: category ?? this.category,
      noteList: noteList ?? List<Note>.from(this.noteList));
}
