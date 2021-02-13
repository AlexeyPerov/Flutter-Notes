import 'package:flutter/material.dart';
import 'package:mynotes/app/theme/theme_constants.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/common/widgets/conditional_widget.dart';

class AddNewNoteCard extends StatefulWidget {
  final Function(String, String) onAddNote;

  const AddNewNoteCard({Key key, @required this.onAddNote}) : super(key: key);

  @override
  _AddNewNoteCardState createState() => _AddNewNoteCardState();
}

class _AddNewNoteCardState extends State<AddNewNoteCard> {
  TextEditingController _titleController;
  TextEditingController _contentsController;
  bool buttonEnabled = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: LinearProgressIndicator(),
      );

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8.0,
        color: kPrimaryMediumColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => {},
          child: Container(
            height: 150,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autocorrect: false,
                        controller: _titleController,
                        maxLines: 1,
                        decoration: textFieldStyle(helperText: null),
                        onChanged: (v) => {
                          setState(() {
                            buttonEnabled =
                                v.isNotEmpty && _contentsController.text.isNotEmpty;
                          })
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ConditionalWidget(
                      fallback: Container(width: 200),
                        child: FlatButton(
                            child: Text('Add'),
                            color: Colors.blue,
                            textColor: Colors.white,
                            splashColor: Colors.blueAccent,
                            onPressed: () async => {
                              if (_titleController.text.isNotEmpty &&
                                  _contentsController.text.isNotEmpty)
                                {
                                  await createNote(_titleController.text,
                                      _contentsController.text)
                                }
                            }),
                        condition: buttonEnabled)
                  ],
                ),
                SizedBox(height: 5),
                TextFormField(
                  autocorrect: false,
                  controller: _contentsController,
                  maxLines: 3,
                  decoration: textFieldStyle(helperText: null),
                  onChanged: (v) => {
                    setState(() {
                      buttonEnabled =
                          v.isNotEmpty && _titleController.text.isNotEmpty;
                    })
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createNote(String title, String contents) async {
    setState(() {
      loading = true;
    });

    await widget.onAddNote(title, contents);

    setState(() {
      loading = false;
    });
  }
}
