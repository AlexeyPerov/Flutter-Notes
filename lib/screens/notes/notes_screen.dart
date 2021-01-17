import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: noteList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildNoteCard(context, noteList[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateEditPage(context),
        child: Icon(Icons.add),
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

  Dismissible _buildNoteCard(BuildContext context, Note note) => Dismissible(
        direction: DismissDirection.endToStart,
        background: Card(
          elevation: 8.0,
          child: Container(
            color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
          child: InkWell(
            onTap: () => _navigateToCreateEditPage(context, note: note),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(note.title),
                  Checkbox(
                    value: note.archived,
                    onChanged: (value) => onArchive(note.id, !note.archived),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
