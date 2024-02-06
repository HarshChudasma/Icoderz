import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CmnDatePicker{
  // user for the common datepicker
  static Future<DateTime?> datePicker(BuildContext context) async {
    DateTime dateTime = (await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: context.theme.primaryColor,
                ),
              ), child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)))!;
    return dateTime;
  }
}