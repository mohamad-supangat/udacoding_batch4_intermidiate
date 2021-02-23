import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class Auth {
  Future<User> userAuth() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(localStorage.getString('user')));
  }

  // Future<User> user() async {
  //   Response response = await callApi().get('/user/auth');
  //   return User.fromJson(response.data);
  // }

  getUser() async {}

  Future<String> token() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  Future<bool> removeToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    return true;
  }

  // Future<bool> logout() async {
  //   try {
  //     await callApi().get('/user/logout');
  //   } finally {
  //     await removeToken();
  //   }
  //   return true;
  // }
}
