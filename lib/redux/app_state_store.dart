import 'package:async_redux/async_redux.dart';
import 'models/note.dart';

var store = Store<AppState>(
  initialState: AppState.initialState(),
);

class AppState {
  final List<Note> noteList;

  AppState({this.noteList});

  AppState copy({List<Note> noteList}) =>
      AppState(noteList: noteList ?? this.noteList);

  static AppState initialState() => AppState(noteList: <Note>[]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              noteList == other.noteList;

  @override
  int get hashCode => noteList.hashCode;
}
