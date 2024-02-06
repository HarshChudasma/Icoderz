import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';
import 'package:icoderz/styles/app_colors.dart';
import 'package:icoderz/utils/card_view.dart';
import 'package:icoderz/utils/utility.dart';

class DebitTab extends StatelessWidget {
  DebitTab({super.key});

  final HomeCtrl c = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => c.isLoad() ? const Center(
        child: CircularProgressIndicator(),
      ) :  c.debitItemListModel().isEmpty ? Center(
        child: Text(
          "No Items Found, Please add item",
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) : ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
        itemCount: c.debitItemListModel().length,
        itemBuilder: (context, index) {
          return CardView(textColor: AppColors.redClr,itemListModel: c.debitItemListModel[index],);
        },
        separatorBuilder: (context, index) {
          return Utility.uiSizedBix(6.0, 0);
        },
      ),
    );
  }
}
