import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './models/user.dart';
import './models/employee.dart';

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
        '''CREATE TABLE "employees" ("id" integer not null primary key autoincrement, "name" varchar not null, "email" varchar not null, "phone_number" varchar not null, "gender" varchar check ("gender" in ('male', 'female', 'other')) not null, "photo" text, "address" text not null, "position" varchar not null)''');
  }

  // add user
  Future<User> addUser(User user) async {
    final db = await this.database;
    user.id = await db.insert('users', user.toJson());
    return user;
  }

  // update user
  Future<User> updateUser(User user, int id) async {
    final db = await this.database;
    user.id = await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return user;
  }

  // get user login
  Future<User> getUserLogin({
    username,
    password,
  }) async {
    final db = await this.database;
    List users = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (users.length > 0) {
      return User.fromJson(users.first);
    }

    return null;
  }

  // get user detail
  Future<User> getUser(id) async {
    final db = await this.database;
    List users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (users.length > 0) {
      return User.fromJson(users.first);
    }
    return null;
  }

  // start of employee section
  // add employee
  Future<Employee> addEmployee(Employee employee) async {
    final db = await this.database;
    employee.id = await db.insert('employees', employee.toJson());
    return employee;
  }

  // update employee
  Future<Employee> updateEmployee(Employee employee, int id) async {
    final db = await this.database;
    employee.id = await db.update(
      'employees',
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return employee;
  }

  // delete employee
  Future<int> deleteEmployee(int id) async {
    final db = await this.database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // get all employees
  Future<List<Employee>> getEmployees() async {
    final db = await this.database;
    List employees = await db.query(
      'employees',
      orderBy: 'name',
    );

    return employeesFromJson(employees);
  }
}
