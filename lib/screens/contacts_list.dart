// ignore_for_file: no_logic_in_create_state

import 'package:Bytebank/components/centered_message.dart';
import 'package:Bytebank/components/progress.dart';
import 'package:Bytebank/dao/contact_dao.dart';
import 'package:Bytebank/models/contact.dart';
import 'package:Bytebank/screens/contact_form.dart';
import 'package:Bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  _ContactsListState();

  ContactDao contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder(
        future: contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data as List<Contact>;
              if (contacts.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact c = contacts[index];
                    return ItemContact(
                      c: c,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(c),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
              } else {
                return const CenteredMessage(
                  'No Contacts found!',
                  icon: Icons.warning,
                );
              }
            default:
              break;
          }
          return const Center();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemContact extends StatelessWidget {
  const ItemContact({
    Key? key,
    required this.c,
    required this.onClick,
  }) : super(key: key);

  final Contact c;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Card(
          child: ListTile(
            title: Text(
              c.name,
              style: const TextStyle(fontSize: 24.0),
            ),
            subtitle: Text(
              c.accountNumber.toString(),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
