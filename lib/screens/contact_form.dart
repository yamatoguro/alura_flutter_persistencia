// ignore_for_file: prefer_const_constructors

import 'package:Bytebank/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactForm extends StatefulWidget {
  ContactForm({Key? key}) : super(key: key);

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerConta = TextEditingController();

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: widget._controllerNome,
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: widget._controllerConta,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Account Number',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: () {
                  final String name = widget._controllerNome.text;
                  final int account =
                      int.tryParse(widget._controllerConta.text)!;
                  final Contact c = Contact(0, name, account);
                  Navigator.pop(context, c);
                },
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
