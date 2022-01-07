import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green[900], secondary: Colors.blueAccent[700]),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/bytebank_logo.png'),
            Container(
              height: 120,
              width: 100,
              color: Colors.green[900],
              child: Column(
                children: const [
                  Icon(Icons.people_alt_outlined),
                  Text('Contacts'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
