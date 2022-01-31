import 'package:Bytebank/components/progress.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({Key? key, this.message = 'Unknown Error!'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing'),
      ),
      body: Progress(
        message: 'Sending...',
      ),
    );
  }
}
