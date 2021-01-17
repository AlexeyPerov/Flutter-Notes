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
