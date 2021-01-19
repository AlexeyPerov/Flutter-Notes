import 'package:async_redux/async_redux.dart';
import 'package:mynotes/redux/models/note_category.dart';
import 'package:mynotes/redux/models/note_filter.dart';

var store = Store<AppState>(
  initialState: AppState.initialState(),
);

class AppState {
  final List<NoteCategory> categories;
  final NoteFilter noteFilter;

  AppState({this.categories, this.noteFilter});

  AppState copy({List<NoteCategory> categories, NoteFilter noteFilter}) => AppState(
      categories: categories ?? this.categories,
      noteFilter: noteFilter ?? this.noteFilter);

  static AppState initialState() =>
      AppState(categories: <NoteCategory>[], noteFilter: null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          categories == other.categories &&
          noteFilter == other.noteFilter;

  @override
  int get hashCode => categories.hashCode ^ noteFilter.hashCode;
}
