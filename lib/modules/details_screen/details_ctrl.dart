import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icoderz/backend/category_repo_impl.dart';
import 'package:icoderz/backend/categorylist_repository.dart';
import 'package:icoderz/models/category_model.dart';
import 'package:icoderz/models/item_list_model.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';

class DetailsCtrl extends GetxController{

  RxString header = ''.obs;
  RxInt credit = 0.obs;

  CategoryListRepository categoryListRepoImpl = CategoryListRepoImpl();
  RxList<CategorylistModel> categoryListModel = RxList<CategorylistModel>();
  RxList<ItemListModel> itemList = RxList<ItemListModel>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final HomeCtrl c =Get.find<HomeCtrl>();
  RxBool isLoad = false.obs;
  RxBool isAdLoad = false.obs;
  RxInt selected = 0.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    isLoad(true);
    var arguments = Get.arguments;
    header(arguments['type']);
    credit.value = header.value == "Credit" ? 0 : 1;
    categoryListModel.value = await categoryListRepoImpl.caegoryListApiCall(isCredit: credit.value) ?? [];
    itemList.value = credit() == 0 ? c.creditItemListModel() : c.debitItemListModel();
    if(categoryListModel.isEmpty){
      Get.back();
    }
    isLoad(false);
  }



}