import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  final String title;
  final String content;
  const DialogCustom({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(title),
        content: Text(content));
  }
}
