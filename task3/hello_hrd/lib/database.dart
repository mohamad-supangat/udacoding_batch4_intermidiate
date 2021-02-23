import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './models/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider _instance = DBProvider._();
  static Database _database;

  factory DBProvider() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hello_hrd.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    // users table
    await db.execute(
        'CREATE TABLE "users" ("id" integer not null primary key autoincrement, "name" varchar not null, "username" varchar not null, "email" varchar not null, "photo" text, "email_verified_at" datetime, "password" varchar not null)');

    // employees table
    await db.execute(
        '''CREATE TABLE "employees" ("id" integer not null primary key autoincrement, "name" varchar not null, "email" varchar not null, "phone_number" varchar not null, "gender" varchar check ("gender" in ('male', 'female', 'other')) not null, "photo" text, "address" text not null, "positon" varchar not null)''');
  }

  // add new user to database
  Future<User> addUser(User user) async {
    final db = await this.database;
    user.id = await db.insert('users', user.toJson());
    return user;
  }
}
