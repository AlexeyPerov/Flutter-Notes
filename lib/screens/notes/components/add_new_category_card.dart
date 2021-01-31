import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/themes.dart';
import 'package:mynotes/common/widgets/conditional_widget.dart';

class AddNewCategoryCard extends StatefulWidget {
  final Function(String) onAddCategory;

  const AddNewCategoryCard({Key key, @required this.onAddCategory})
      : super(key: key);

  @override
  _AddNewCategoryCardState createState() => _AddNewCategoryCardState();
}

class _AddNewCategoryCardState extends State<AddNewCategoryCard> {
  TextEditingController _titleController;
  bool buttonEnabled = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Container(
          width: 150,
          height: 100,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 45, right: 45, top: 35, bottom: 35),
            child: CircularProgressIndicator(),
          ));

    return Card(
      elevation: 8.0,
      color: Color(0xFFF5F7FB),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 150,
        height: 100,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autocorrect: false,
              controller: _titleController,
              decoration: textFieldStyle(helperText: null),
              onChanged: (v) => {
                setState(() {
                  buttonEnabled = v.isNotEmpty;
                })
              },
            ),
            ConditionalWidget(
                child: FlatButton(
                    child: Text('Add'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () async => {
                      if (_titleController.text.isNotEmpty)
                        {await createCard(_titleController.text)}
                    }),
                condition: buttonEnabled)
          ],
        ),
      ),
    );
  }

  createCard(String title) async {
    setState(() {
      loading = true;
    });

    await widget.onAddCategory(title);

    setState(() {
      loading = false;
    });
  }
}
