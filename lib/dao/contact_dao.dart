import 'package:Bytebank/database/app_database.dart';
import 'package:Bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String createTable = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER'
      ')';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account';

  Future<int> save(Contact c) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> value = {};
    value[_name] = c.name;
    value[_accountNumber] = c.accountNumber;
    return db.insert(_tableName, value);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in await db.query(_tableName)) {
      final Contact c = Contact(row[_id], row[_name], row[_accountNumber]);
      contacts.add(c);
    }
    return contacts;
  }
}
