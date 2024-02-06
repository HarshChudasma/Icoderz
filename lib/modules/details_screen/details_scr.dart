import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/database/itemlist_tbl.dart';
import 'package:icoderz/models/category_model.dart';
import 'package:icoderz/models/item_list_model.dart';
import 'package:icoderz/modules/details_screen/details_ctrl.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';
import 'package:icoderz/styles/app_colors.dart';
import 'package:icoderz/utils/card_view.dart';
import 'package:icoderz/utils/cmn_btn.dart';
import 'package:icoderz/utils/cmn_datepicker.dart';
import 'package:icoderz/utils/cmn_drpdwn.dart';
import 'package:icoderz/utils/cmn_txtfield.dart';
import 'package:icoderz/utils/logger.dart';
import 'package:icoderz/utils/utility.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final DetailsCtrl c = Get.put(DetailsCtrl());
  final HomeCtrl hc = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: () {
                hc.getItemListData();
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 24.0,
                color: AppColors.blackColor,
              ),
            ),
          ).paddingAll(6.0),
          titleSpacing: 0,
          title: Text(
            c.header(),
            style: context.textTheme.labelMedium
                ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                c.itemList.add(
                  ItemListModel(
                      id: -1,
                      type: -1,
                      title: '',
                      category: '',
                      amount: 0.0,
                      createdDate: DateTime.now().toString(),
                      referenceNo: 0,
                      titleCtrl: TextEditingController(),
                      refrenceNoCtrl: TextEditingController(),
                      amountCtrl: TextEditingController(),
                      categoryId: 0,
                      dateCtrl: TextEditingController(),
                      categoryCtrl: TextEditingController(),
                      isEdit: false.obs),
                );
              },
              child: Icon(
                Icons.add,
                size: 24.0,
                color: context.theme.primaryColor,
              ).paddingOnly(right: 12.0),
            ),
          ],
        ),
        body: Obx(
          () => c.itemList().isEmpty
              ? Center(
                  child: Text(
                    "No Items Found, Please add item",
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Form(
                  key: c.formKey,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    itemCount: c.itemList().length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        elevation: 2,
                        child: ColoredBox(
                          color: AppColors.greyColor.withOpacity(0.4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => IgnorePointer(
                                    ignoring: c.itemList[index].isEdit!.value,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        c.itemList[index].isEdit!()
                                            ? CmnTxtFld(
                                                textController:
                                                    c.itemList[index].categoryCtrl,
                                              )
                                            : CmnDrpDwnBtn(
                                                drpDwnValidation: (value) {
                                                  if (value == -1) {
                                                    return "Please select category";
                                                  }
                                                },
                                                drpItem: c.categoryListModel
                                                    .map(
                                                      (element) =>
                                                          DropdownMenuItem(
                                                        value:
                                                            element.categoryId,
                                                        child: Text(
                                                          element.categoryName,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  c.selected.value = index;
                                                  c.itemList[index].categoryId =
                                                      value;
                                                },
                                                textfieldHint:
                                                    "Select Category",
                                              ),
                                        Utility.uiSizedBix(6.0, 0),
                                        CmnTxtFld(
                                          textController:
                                              c.itemList[index].titleCtrl,
                                          txtonChanged: (p0) {
                                            c.selected.value = index;
                                          },
                                          textFldValidate: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter title";
                                            }
                                          },
                                          textfieldHint:
                                              "Enter Title ${index + 1}",
                                        ),
                                        Utility.uiSizedBix(12.0, 0),
                                        CmnTxtFld(
                                          textReadOnly: true,
                                          fillColor: context
                                              .theme.colorScheme.onPrimary,
                                          textController:
                                              c.itemList[index].dateCtrl,
                                          textfieldHint: "Select Date",
                                          textOnTap: () async {
                                            c.itemList[index].selectedString
                                                    .value =
                                                (await CmnDatePicker.datePicker(
                                                    context))!;
                                            c.itemList[index].dateCtrl.text = c
                                                .itemList[index]
                                                .selectedString
                                                .value
                                                .toString();
                                          },
                                          textFldValidate: (value) {
                                            if (c.itemList[index].dateCtrl.text
                                                .isEmpty) {
                                              return "Please select Date";
                                            }
                                          },
                                          txtonChanged: (value) {
                                            if (value.length >= 10) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          textInputType: TextInputType.number,
                                          maxLength: 10,
                                          suffixWidget:
                                              Icon(Icons.date_range_outlined)
                                                  .paddingAll(12.0),
                                        ),
                                        Utility.uiSizedBix(12.0, 0),
                                        CmnTxtFld(
                                          textController:
                                              c.itemList[index].refrenceNoCtrl,
                                          textInputType: TextInputType.number,
                                          txtonChanged: (p0) {
                                            c.selected.value = index;
                                          },
                                          textFldValidate: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter refrence No";
                                            }
                                          },
                                          textfieldHint:
                                              "Enter Reference No ${index + 1}",
                                        ),
                                        Utility.uiSizedBix(6.0, 0),
                                        CmnTxtFld(
                                          textController:
                                              c.itemList[index].amountCtrl,
                                          txtonChanged: (p0) {
                                            c.selected.value = index;
                                          },
                                          textFldValidate: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter amount";
                                            }
                                          },
                                          textInputType: TextInputType.number,
                                          textfieldHint:
                                              "Enter Amout ${index + 1}",
                                        ),
                                      ],
                                    ).paddingAll(6.0),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      c.selected.value = index;
                                      c.itemList[index].isEdit!.value =
                                          !c.itemList[index].isEdit!.value;
                                      logger.i(
                                          "check value is edit or not : ${c.itemList[index].isEdit!.value}");
                                    },
                                    icon: const Icon(
                                      Icons.mode_edit_outline_outlined,
                                      size: 28.0,
                                    ),
                                  ),
                                  Utility.uiSizedBix(12.0, 0),
                                  InkWell(
                                      onTap: () {
                                        if (c.itemList[index].id != -1) {
                                          ItemListTable.deleteItemByProductId(
                                                  itemId: c.itemList[index].id!)
                                              .then((value) {
                                            Utility.showToast(
                                                "Item Deleted Successfully!!",
                                                context);
                                            c.itemList.removeAt(index);
                                            c.selected.value = 0;
                                          });
                                        } else {
                                          c.itemList.removeAt(index);
                                          c.selected.value = 0;
                                        }
                                      },
                                      child: const Icon(
                                        Icons.delete_outline_rounded,
                                        size: 28.0,
                                      )),
                                ],
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 8.0, vertical: 8.0),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Utility.uiSizedBix(6.0, 0);
                    },
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => c.itemList().isEmpty
              ? Utility.uiSizedBix(0, 0)
              : c.isAdLoad()
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CmnBtnWidget(
                          btnClk: () {
                            if (c.formKey.currentState!.validate()) {
                              c.formKey.currentState!.save();
                              c.isAdLoad(true);
                              if (c.itemList[c.selected.value].categoryId !=
                                  0) {
                                CategorylistModel category = c.categoryListModel
                                    .firstWhere((element) =>
                                        element.categoryId ==
                                        c.itemList[c.selected.value]
                                            .categoryId);
                                if (c.itemList[c.selected.value].id != -1) {
                                  c.itemList[c.selected.value].isEdit!.value =
                                      true;
                                  ItemListModel itemListModel = ItemListModel(
                                      titleCtrl: c
                                          .itemList[c.selected.value].titleCtrl,
                                      refrenceNoCtrl: c
                                          .itemList[c.selected.value]
                                          .refrenceNoCtrl,
                                      amountCtrl: c.itemList[c.selected.value]
                                          .amountCtrl,
                                      categoryCtrl: c.itemList[c.selected.value]
                                          .categoryCtrl,
                                      categoryId: category.categoryId,
                                      category: category.categoryName,
                                      createdDate: DateTime.now().toString(),
                                      dateCtrl:
                                          c.itemList[c.selected.value].dateCtrl,
                                      type: c.credit());
                                  ItemListTable.updateItemNew(
                                          itemModel: itemListModel,
                                          itemid:
                                              c.itemList[c.selected.value].id!)
                                      .then((value) {
                                    Utility.showToast(
                                        "Item Updated Successfully", context);
                                  });
                                } else {
                                  ItemListModel itemListModel = ItemListModel(
                                      titleCtrl: c
                                          .itemList[c.selected.value].titleCtrl,
                                      refrenceNoCtrl: c
                                          .itemList[c.selected.value]
                                          .refrenceNoCtrl,
                                      categoryCtrl: c.itemList[c.selected.value]
                                          .categoryCtrl,
                                      amountCtrl: c.itemList[c.selected.value]
                                          .amountCtrl,
                                      categoryId: category.categoryId,
                                      dateCtrl:
                                          c.itemList[c.selected.value].dateCtrl,
                                      category: category.categoryName,
                                      createdDate: DateTime.now().toString(),
                                      type: c.credit());
                                  ItemListTable.addNewItem(
                                          itemModel: itemListModel)
                                      .then((value) async {
                                        logger.i("value get when added : ${value}");
                                        ItemListModel? itemListModel = await ItemListTable.getItemById(productId: value);
                                        if(itemListModel != null){
                                          c.itemList[c.selected.value] = itemListModel;
                                        }
                                    Utility.showToast(
                                        "Item Added Successfully", context);
                                  });
                                }
                                c.isAdLoad(false);
                              } else {
                                Utility.showToast(
                                    "Please select category", context);
                                c.isAdLoad(false);
                              }
                            }
                          },
                          btnText: c.itemList[c.selected.value].id != -1
                              ? "Update"
                              : "Add")
                      .paddingAll(8.0),
        ),
      ),
    );
  }
}
