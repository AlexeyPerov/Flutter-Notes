class Note {
  final String id;
  final String title;
  final String contents;
  final bool archived;

  Note({this.id, this.title, this.contents, this.archived});

  factory Note.initial() =>
      Note(id: '', title: '', contents: '', archived: false);

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
