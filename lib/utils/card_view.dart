import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/models/item_list_model.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';
import 'package:icoderz/styles/app_colors.dart';
import 'package:icoderz/utils/utility.dart';
import 'package:intl/intl.dart';

class CardView extends StatelessWidget {
  final Color textColor;
  final ItemListModel itemListModel;
  CardView({super.key,required this.textColor,required this.itemListModel});

  final HomeCtrl c = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 2,
      child: ColoredBox(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              itemListModel.title ?? '',
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Utility.uiSizedBix(6.0, 0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  itemListModel.category ?? '',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Spacer(),
                Text(
                  itemListModel.referenceNo.toString() ?? '',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Utility.uiSizedBix(6.0, 0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd MMM yyyy").format(DateTime.parse(itemListModel.createdDate!)),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                Text(
                  c.currencyFormat.format(itemListModel.amount),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(6.0),
      ),
    );
  }
}
