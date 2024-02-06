import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icoderz/database/db_helper.dart';
import 'package:icoderz/database/itemlist_tbl.dart';
import 'package:icoderz/models/item_list_model.dart';
import 'package:icoderz/routes/app_routes.dart';
import 'package:icoderz/services/prefs_services.dart';
import 'package:icoderz/utils/logger.dart';
import 'package:intl/intl.dart';

class HomeCtrl extends GetxController {
  RxInt position = 0.obs;
  PageController pageCtrl = PageController(initialPage: 0);

  RxString radioGrpValue = 'Credit'.obs;

  RxBool isLoad = false.obs;
  RxInt selected = 0.obs;

  RxDouble creditValue = 0.0.obs;
  RxDouble debitValue = 0.0.obs;

  RxList<ItemListModel> creditItemListModel = RxList<ItemListModel>();
  RxList<ItemListModel> debitItemListModel = RxList<ItemListModel>();

  NumberFormat currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '₹');

  @override
  void onInit() {
    getItemListData();
    super.onInit();
  }

  // Get All Item List Data
  getItemListData() async {
    isLoad(true);
    try {
      List<ItemListModel> itemListModel =
          await ItemListTable.getAllItemsFromDb();
      updateTotal(itemListModel: itemListModel);
      creditItemListModel.value =
          itemListModel.where((element) => element.type == 0).toList();
      debitItemListModel.value =
          itemListModel.where((element) => element.type == 1).toList();
      isLoad(false);
    } catch (e) {
      logger.i("Get All Item Data : ${e.toString()}");
      isLoad(false);
    }
  }

  void updateTotal({required List<ItemListModel> itemListModel}) {
    creditValue(0);
    debitValue(0);
    for (ItemListModel item in itemListModel) {
      if(item.type == 0){
        creditValue.value += item.amount!;
      } else {
        debitValue.value += item.amount!;
      }
    }
  }

  logoutWhenComplete() async {
    await DbHelper.deleteDatabase();
    await prefs.removeValue('userModel');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.LOGIN_SCREEN);
  }



}
