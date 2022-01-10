import 'package:Bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'account INTEGER'
            ')');
      },
      version: 1,
    );
  });
}

Future<int> save(Contact c) {
  return createDatabase().then((db) {
    final Map<String, dynamic> value = Map();
    value['id'] = c.id;
    value['name'] = c.name;
    value['account'] = c.account;
    return db.insert('contacts', value);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact c = Contact(map['id'], map['name'], map['account']);
        contacts.add(c);
      }
      return contacts;
    });
  });
}
