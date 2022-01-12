// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  TransactionAuthDialog({Key? key, required this.onConfirm}) : super(key: key);

  final Function(String password) onConfirm;

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _controller,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(_controller.text);
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
