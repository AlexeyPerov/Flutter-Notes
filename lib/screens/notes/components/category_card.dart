import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/app/theme/theme_constants.dart';

class CategoryCard extends StatelessWidget {
  final Function(String) onFilter;
  final bool selected;
  final String id;
  final String name;

  const CategoryCard(
      {Key key, this.onFilter, this.selected, this.id, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8.0,
      color: selected ? kPrimaryLightColor : colorScheme.primaryVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => onFilter(id),
        child: Container(
          width: 150,
          height: 100,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name,
                  style:
                      textTheme.headline4.apply(color: colorScheme.onSurface))
            ],
          ),
        ),
      ),
    );
  }
}
