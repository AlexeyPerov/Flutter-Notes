import 'package:flutter/material.dart';

@immutable
class NoteCategory {
  final String id;
  final String name;

  NoteCategory({this.id, this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
