import 'package:flutter/material.dart';

// Global variables for themeData parameters
final Color primaryColor = Colors.blue;
final double fontSize = 16.0;
final FontWeight fontWeight = FontWeight.normal;
final EdgeInsets padding = EdgeInsets.all(16.0);

// Example usage:
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  ),
  buttonTheme: ButtonThemeData(
    padding: padding,
  ),
);
