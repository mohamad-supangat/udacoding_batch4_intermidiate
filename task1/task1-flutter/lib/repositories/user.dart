import 'package:dio/dio.dart';

import '../helpers/api.dart';
import '../models/user.dart';

class UserRepository {
  static Future<User> getUserAuth() async {
    try {
      final Response response = await callApi().get('/user/auth');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('error geting user auth data');
    }
  }

  static Future saveUser(data) async {
    try {
      final Response response =
          await callApi().post('/user/update_profile', data: data);
      return response;
    } catch (e) {
      throw Exception('error geting user auth data');
    }
  }
}
