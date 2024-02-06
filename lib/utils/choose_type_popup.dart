import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';
import 'package:icoderz/routes/app_routes.dart';
import 'package:icoderz/utils/utility.dart';

class ChooseTypePopup extends StatelessWidget {
  ChooseTypePopup({super.key});

  final HomeCtrl c = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose Type",
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Utility.uiSizedBix(12.0, 0),
            Row(
              children: [
                SizedBox(
                  height: 40.0,
                  width: 30.0,
                  child: Obx(
                    () => Radio(
                      activeColor: context.theme.primaryColor,
                      value: 'Credit',
                      groupValue: c.radioGrpValue.value,
                      onChanged: (val) {
                        c.radioGrpValue.value = val.toString();
                      },
                    ),
                  ),
                ),
                Text(
                  'Credit',
                  style: context.textTheme.labelMedium?.copyWith(),
                ),
                SizedBox(
                  height: 40.0,
                  width: 30.0,
                  child: Obx(
                    () => Radio(
                      activeColor: context.theme.primaryColor,
                      value: 'Debit',
                      groupValue: c.radioGrpValue.value,
                      onChanged: (val) {
                        c.radioGrpValue.value = val.toString();
                      },
                    ),
                  ),
                ),
                Text(
                  'Debit',
                  style: context.textTheme.labelMedium?.copyWith(),
                ),
              ],
            ),
            Utility.uiSizedBix(8.0, 0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.DETAILS_SCREEN,arguments: {'type':c.radioGrpValue()});
                  },
                  child: Text(
                    "Ok",
                    style: context.textTheme.labelMedium?.copyWith(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancle",
                    style: context.textTheme.labelMedium?.copyWith(),
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(16.0),
      ),
    );
  }
}
