import 'package:flutter/material.dart';

import '../pages/splashscreen.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/home.dart';
import '../pages/user/detail.dart';

var routes = <String, WidgetBuilder>{
  '/splashScreen': (context) => SplashScreen(),
  '/login': (context) => Login(),
  '/register': (context) => Register(),
  '/home': (context) => Home(),
  '/user/detail': (context) => UserDetail(),
};
