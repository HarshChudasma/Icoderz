import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

ItemListModel itemListModelFromJson(String str) => ItemListModel.fromJson(json.decode(str));

String itemListModelToJson(ItemListModel data) => json.encode(data.toJson());

class ItemListModel {
  int? id;
  String? title;
  String? category;
  int? categoryId;
  String? createdDate;
  int? referenceNo;
  double? amount;
  int? type;
  TextEditingController titleCtrl;
  TextEditingController refrenceNoCtrl;
  TextEditingController amountCtrl;
  TextEditingController dateCtrl;
  TextEditingController categoryCtrl;
  Rx<DateTime> selectedString = Rx<DateTime>(DateTime(0));
  RxBool? isEdit = true.obs;

  ItemListModel({
    this.id,
    this.title,
    this.category,
    this.createdDate,
    this.referenceNo,
    this.amount,
    this.type,
    required this.titleCtrl,
    required this.refrenceNoCtrl,
    required this.amountCtrl,
    required this.dateCtrl,
    required this.categoryCtrl,
    this.categoryId,
    this.isEdit,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
    id: json["id"] ?? -1,
    title: json["title"] ?? '',
    category: json["category"] ?? '',
    createdDate:  json["created_date"] ?? '',
    referenceNo: json["refrence_no"] ?? 0,
    amount: json["amount"] ?? 0.0,
    type: json["type"] ?? -1,
    titleCtrl: TextEditingController(text: json["title"] ?? ''),
    refrenceNoCtrl:TextEditingController(text: json["refrence_no"].toString() ?? ''),
    amountCtrl: TextEditingController(text: json["amount"].toString() ?? ''),
    dateCtrl: TextEditingController(text: json["created_date"] ?? ''),
    categoryCtrl: TextEditingController(text: json["category"] ?? ''),
    categoryId: json["category_id"] ?? 0,
    isEdit: true.obs
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "created_date": createdDate,
    "refrence_no": referenceNo,
    "amount": amount,
    "type": type,
  };

  Map<String, dynamic> toMapForItem() {
    return <String, dynamic>{
      "title": titleCtrl.text,
      "category": category,
      "created_date": dateCtrl.text,
      "refrence_no": refrenceNoCtrl.text,
      "amount": amountCtrl.text,
      "type": type,
      "category_id": categoryId,
    };
  }

}
