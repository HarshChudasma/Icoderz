import 'dart:convert';

import 'package:get/get.dart';

CategorylistModel categorylistModelFromJson(String str) => CategorylistModel.fromJson(json.decode(str));

String categorylistModelToJson(CategorylistModel data) => json.encode(data.toJson());

class CategorylistModel {
  int categoryId;
  String categoryName;
  RxInt isSelected = 0.obs;

  CategorylistModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory CategorylistModel.fromJson(Map<String, dynamic> json) => CategorylistModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
  };
}
