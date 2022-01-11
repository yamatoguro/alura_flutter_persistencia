// ignore_for_file: no_logic_in_create_state

import 'package:Bytebank/models/contact.dart';
import 'package:Bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);
  List contacts = [];
  @override
  State<ContactsList> createState() => _ContactsListState(contacts);
}

class _ContactsListState extends State<ContactsList> {
  _ContactsListState(this.contacts);

  final List contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView(
        children: [...contacts],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          ).then((value) {
            setState(() {
              widget.contacts.add(ItemContact(c: value));
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemContact extends StatelessWidget {
  const ItemContact({Key? key, required this.c}) : super(key: key);

  final Contact c;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          c.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          c.account.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
