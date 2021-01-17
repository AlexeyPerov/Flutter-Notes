import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/theme_constants.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/screens/note_edit/note_edit_screen.dart';

class NotesScreen extends StatelessWidget {
  final List<Note> noteList;
  final Function() onQuery;
  final Function(String, String) onCreate;
  final Function(String, String, String) onUpdate;
  final Function(String) onRemove;
  final Function(String, bool) onArchive;
  final VoidCallback onPop;

  NotesScreen({
    Key key,
    this.noteList,
    this.onQuery,
    this.onCreate,
    this.onUpdate,
    this.onRemove,
    this.onArchive,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Notes', style: primaryTextStyle())),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: kIsWeb ? min(kMinWebContainerWidth, width) : null,
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: noteList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildNoteCard(context, noteList[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateEditPage(context),
        backgroundColor: Color(0xFF757575),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Card(
          elevation: 8.0,
          child: Container(
            color: Colors.red[300],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'Remove'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) => onRemove(note.id),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => _navigateToCreateEditPage(context, note: note),
            child: Container(
              height: 120,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(note.title),
                      Checkbox(
                        value: note.archived,
                        onChanged: (value) => onArchive(note.id, !note.archived),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(alignment: Alignment.topLeft, child: Text(note.contents))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToCreateEditPage(BuildContext context, {Note note}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(
          note: note,
          onCreate: onCreate,
          onUpdate: onUpdate,
          onPop: onPop,
        ),
      ),
    );
  }
}
