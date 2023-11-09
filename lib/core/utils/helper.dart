import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFFEA0000),
        textColor: const Color(0xFFFFFFFF),
        fontSize: 16);
  }
}
