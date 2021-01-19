class Note extends NoteContents {
  final String id;

  Note({this.id, String title, String contents, bool archived})
      : super(title: title, contents: contents, archived: archived);

  factory Note.fromContents(String id, NoteContents noteContents) => Note(
      id: id,
      title: noteContents.title,
      contents: noteContents.contents,
      archived: noteContents.archived);

  Note copy({
    String id,
    String title,
    String contents,
    bool archived,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        contents: contents ?? this.contents,
        archived: archived ?? this.archived,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          contents == other.contents &&
          archived == other.archived;

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ contents.hashCode ^ archived.hashCode;
}

class NoteContents {
  final String title;
  final String contents;
  final bool archived;

  NoteContents({this.title, this.contents, this.archived});

  factory NoteContents.empty() =>
      NoteContents(title: '', contents: '', archived: false);
}
