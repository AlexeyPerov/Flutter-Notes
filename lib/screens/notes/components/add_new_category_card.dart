import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (loading) {
      return Container(
          width: 150,
          height: 100,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 45, right: 45, top: 35, bottom: 35),
            child: CircularProgressIndicator(),
          ));
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8.0,
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
              onChanged: (v) => {
                setState(() {
                  buttonEnabled = v.isNotEmpty;
                })
              },
            ),
            Align(
              alignment: Alignment.center,
              child: ConditionalWidget(
                  child: _addButton(textTheme, colorScheme),
                  condition: buttonEnabled),
            )
          ],
        ),
      ),
    );
  }

  IconButton _addButton(TextTheme textTheme, ColorScheme colorScheme) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: "Add",
      onPressed: () async => {
        if (_titleController.text.isNotEmpty)
          {await createCard(_titleController.text)}
      },
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
