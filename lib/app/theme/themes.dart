import 'package:flutter/material.dart';
import 'package:mynotes/app/theme/theme_constants.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme(),
      appBarTheme: appBarTheme());
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(color: Colors.white, shadowColor: Colors.white);
}

TextStyle primaryTextStyle() => TextStyle(color: kTextColor);

commonBoxShadow() {
  return BoxShadow(
      color: Colors.black26, offset: Offset(0, 2), blurRadius: 10.0);
}

slightBoxShadow() {
  return BoxShadow(
      color: Colors.black26, offset: Offset(0, 1), blurRadius: 5.0);
}

InputDecoration textFieldStyle({String helperText = ''}) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(12),
    helperText: helperText,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[500])),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300])),
  );
}
