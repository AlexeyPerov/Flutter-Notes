import 'package:flutter/material.dart';
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
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => {},
          child: Container(
            height: 175,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  controller: _titleController,
                  maxLines: 1,
                  onChanged: (v) => {
                    setState(() {
                      buttonEnabled = v.isNotEmpty;
                    })
                  },
                ),
                SizedBox(height: 5),
                ConditionalWidget(
                    fallback: Container(width: 200),
                    child: TextFormField(
                      autocorrect: false,
                      controller: _contentsController,
                      maxLines: 2,
                      onChanged: (v) => {
                        setState(() {
                          buttonEnabled =
                              v.isNotEmpty && _titleController.text.isNotEmpty;
                        })
                      },
                    ),
                    condition: buttonEnabled),
                ConditionalWidget(
                    fallback: Container(width: 200),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: "Add",
                      onPressed: () async => {
                        if (_titleController.text.isNotEmpty)
                          {
                            await createNote(
                                _titleController.text, _contentsController.text)
                          }
                      },
                    ),
                    condition: buttonEnabled)
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
