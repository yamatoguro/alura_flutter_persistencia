import 'package:Bytebank/screens/contacts_list.dart';
import 'package:Bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green[900], secondary: Colors.blueAccent[700]),
      ),
      home: const Dashboard(),
    );
  }
}
