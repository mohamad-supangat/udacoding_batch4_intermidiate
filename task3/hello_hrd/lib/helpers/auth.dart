import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../database.dart';
import '../models/user.dart';

class Auth {
  final DBProvider _db = DBProvider();

  Future<User> userAuth() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(localStorage.getString('auth')));
  }

  Future<User> getUser() async {
    final User _userAuth = await this.userAuth();
    return await this._db.getUser(_userAuth.id);
  }

  Future<bool> removeToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('auth');
    return true;
  }

  Future<bool> logout() async {
    await removeToken();
    return true;
  }
}
