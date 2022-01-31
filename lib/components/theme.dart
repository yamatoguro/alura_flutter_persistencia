import 'package:flutter/material.dart';

final bytebankTheme = ThemeData(
  primarySwatch: Colors.blue,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent[700],
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.green[900], secondary: Colors.blueAccent[700]),
);
