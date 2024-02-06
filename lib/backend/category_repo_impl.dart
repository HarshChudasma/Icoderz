import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icoderz/backend/categorylist_repository.dart';
import 'package:icoderz/models/category_model.dart';
import 'package:icoderz/utils/logger.dart';

class CategoryListRepoImpl extends CategoryListRepository{
  @override
  Future<List<CategorylistModel>?> caegoryListApiCall({required int isCredit}) async {
    try{
      var dio = Dio();
      var response = await dio.request(
        'https://mocki.io/v1/e81f728b-acf4-4025-8dd9-2a4b2b8a4e18',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> listOfDynamic = response.data[isCredit == 0 ? "creditCategory" : "debitCategory"];
        List<CategorylistModel> listOfCategoryModel = listOfDynamic.map((e) => CategorylistModel.fromJson(e)).toList();
        return listOfCategoryModel;
      } else {
        return null;
      }
    } catch(e){
      logger.e("Error when get Data : ${e.toString()}");
      rethrow;
    }
  }

}