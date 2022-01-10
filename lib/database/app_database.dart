import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY,'
            'name TEXT,'
            'account_number INTEGER'
            ')');
      },
      version: 1,
    );
  });
}
