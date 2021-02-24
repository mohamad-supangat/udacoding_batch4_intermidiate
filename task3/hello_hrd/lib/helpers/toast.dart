import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({
  String type,
  @required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: type == 'error' ? Colors.red : Colors.teal,
    textColor: Colors.white,
  );
}
