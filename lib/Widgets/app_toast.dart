import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

AppToast(String msg, bool error) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: (error) ? Color(0xFFC33025) : Color(0xFF007f5f),
      textColor: Colors.white,
      fontSize: 16.0);
}
