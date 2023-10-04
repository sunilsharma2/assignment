
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> flutterToastMsg(String message)
{
  return Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_LONG);
}
