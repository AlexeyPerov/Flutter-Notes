import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/theme_constants.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/common/utilities/navigator_utilities.dart';
import 'package:mynotes/redux/models/note.dart';
import 'package:mynotes/screens/notes/notes_connector.dart';

class NoteEditScreen extends StatefulWidget {
  final Note note;
  final Function(String, String) onCreate;
  final Function(String, String, String) onUpdate;

  NoteEditScreen({Key key, this.note, this.onCreate, this.onUpdate})
      : super(key: key);

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  String _contents = '';

  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Note', style: primaryTitleTextStyle()),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: kTextColor,
              onPressed: () {
                if (_validateAndSave()) {
                  if (widget.note != null && widget.note.id.isNotEmpty) {
                    widget.onUpdate(
                      widget.note.id,
                      _title,
                      _contents,
                    );
                  } else {
                    widget.onCreate(_title, _contents);
                  }

                  NavigatorUtilities.pushAndRemoveUntil(
                      context, (context) => NotesConnector());
                }
              },
              child: Text("SAVE", style: TextStyle(color: Colors.white)),
              key: Key("bt_save"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: kIsWeb ? min(kMinWebContainerWidth, width) : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      onSaved: (value) => _title = value,
                      initialValue: widget.note?.title,
                    ),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      onSaved: (value) => _contents = value,
                      initialValue: widget.note?.contents,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
