import 'package:Bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
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
}

Future<int> save(Contact c) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> value = {};
  value['name'] = c.name;
  value['account'] = c.account;
  return db.insert('contacts', value);
}

Future<List<Contact>> findAll() async {
  final Database db = await getDatabase();
  final List<Contact> contacts = [];
  for (Map<String, dynamic> row in await db.query('contacts')) {
    final Contact c = Contact(row['id'], row['name'], row['account']);
    contacts.add(c);
  }
  return contacts;
}
