import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'toast.dart';
import 'auth.dart';
import '../config.dart';
import 'dart:developer';
import '../bus.dart';

Dio callApi() {
  BaseOptions options = new BaseOptions(
    baseUrl: config()['apiUrl'],
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Accept': 'application/json',
    },
  );

  Dio _dio = new Dio(options);
  _dio.interceptors.add(LogInterceptor(responseBody: true));
  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (Options options) async {
        // masukan token ke header
        String token = await Auth().token();
        options.headers['authorization'] = 'Bearer $token';
        log(options.headers.toString());
        return options; //continue
      },
      onResponse: (Response response) async {
        return response; // continue
      },
      onError: (DioError e) async {
        // tangkap kode 422 eror / laravel validation
        if (e.response.statusCode == 422) {
          for (List errors in e.response.data['errors'].values) {
            showToast(type: 'error', message: errors.first.toString());
            break;
          }
        } else if (e.response.statusCode == 401) {
          await Auth().removeToken();
          navigatorKey.currentState.pushNamedAndRemoveUntil(
            '/login',
            (Route<dynamic> route) => false,
          );
        } else {
          showToast(type: 'error', message: 'Terjadi kesalahan pada jaringan');
        }
        return e; //continue
      },
    ),
  );

  return _dio;
}
