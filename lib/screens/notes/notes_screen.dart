import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/theme_constants.dart';
import 'package:mynotes/redux/models/note_category.dart';
import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/redux/models/note_filter.dart';
import 'package:mynotes/screens/note_edit/note_edit_screen.dart';

import 'package:mynotes/screens/notes/components/add_new_category_card.dart';
import 'package:mynotes/screens/notes/components/add_new_note_card.dart';
import 'package:mynotes/screens/notes/components/category_card.dart';
import 'package:mynotes/screens/notes/components/note_card.dart';

class NotesScreen extends StatelessWidget {
  final List<NoteCategory> categories;
  final NoteFilter noteFilter;
  final Function() onQuery;
  final Function(String) onAddCategory;
  final Function(String, String) onAddNote;
  final Function(String, String, String) onUpdate;
  final Function(String) onFilter;
  final Function(String) onRemove;
  final Function(String, bool) onArchive;

  NotesScreen(
      {Key key,
      this.categories,
      this.noteFilter,
      this.onQuery,
      this.onAddCategory,
      this.onAddNote,
      this.onUpdate,
      this.onFilter,
      this.onRemove,
      this.onArchive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: new LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (categories == null || noteFilter == null) {
                return Container();
              }

              var height = constraints.hasInfiniteHeight
                  ? MediaQuery.of(context).size.height
                  : constraints.maxHeight;

              return Container(
                width: kIsWeb ? min(kMinWebContainerWidth, width) : null,
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: categories.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == categories.length) {
                              return AddNewCategoryCard(
                                  onAddCategory: onAddCategory);
                            }
                            final category = categories[index];
                            return CategoryCard(
                                id: category.id,
                                name: category.name,
                                onFilter: onFilter,
                                selected: noteFilter.category == category);
                          }),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: height - 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: noteFilter.noteList.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == noteFilter.noteList.length) {
                              return AddNewNoteCard(onAddNote: onAddNote);
                            }
                            return NoteCard(
                                note: noteFilter.noteList[index],
                                onRemove: onRemove,
                                onArchive: onArchive,
                                onNavigateToEditScreen: _navigateToNoteEditPage);
                          }),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNoteEditPage(context, null),
        backgroundColor: Color(0xFF757575),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToNoteEditPage(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NoteEditScreen(note: note, onCreate: onAddNote, onUpdate: onUpdate),
      ),
    );
  }
}
