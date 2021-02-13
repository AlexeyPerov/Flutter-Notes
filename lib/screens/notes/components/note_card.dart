import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/theme_constants.dart';
import 'package:mynotes/redux/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function(String) onRemove;
  final Function(String, bool) onArchive;
  final Function(BuildContext, Note) onNavigateToEditScreen;

  const NoteCard(
      {Key key,
      this.note,
      this.onRemove,
      this.onArchive,
      this.onNavigateToEditScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Card(
          elevation: 8.0,
          child: Container(
            color: kPrimaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'REMOVE',
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
          clipBehavior: Clip.antiAlias,
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () => onNavigateToEditScreen(context, note),
            child: Container(
              height: 120,
              padding: EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(note.title,
                          style: textTheme.headline6.apply(
                              color: colorScheme.onSurface,
                              decoration: note.archived
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                      Checkbox(
                        value: note.archived,
                        onChanged: (value) =>
                            onArchive(note.id, !note.archived),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(note.contents,
                          style: textTheme.bodyText2.apply(
                              color: colorScheme.onSurface,
                              decoration: note.archived
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
