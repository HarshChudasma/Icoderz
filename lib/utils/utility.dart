import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utility{

  static uiSizedBix(double? height, double? width) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }

  static void showToast(String title, BuildContext context) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: title,
      timeInSecForIosWeb: 3,
      backgroundColor: context.theme.primaryColor,
      fontSize: 16.0,
      textColor: context.theme.colorScheme.onPrimary,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

}