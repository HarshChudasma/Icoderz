import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/modules/home_screen/crediit_tab.dart';
import 'package:icoderz/modules/home_screen/debit_tab.dart';
import 'package:icoderz/modules/home_screen/home_ctrl.dart';
import 'package:icoderz/repo/global_repo.dart';
import 'package:icoderz/styles/app_colors.dart';
import 'package:icoderz/utils/choose_type_popup.dart';
import 'package:icoderz/utils/utility.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeCtrl c = Get.put(HomeCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            globalRepo.user().image!,
            height: 42,
            width: 42,
          ),
        ).paddingAll(6.0),
        titleSpacing: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              globalRepo.user().name ?? '',
              style: context.textTheme.labelMedium
                  ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Utility.uiSizedBix(4, 0),
            Text(
              globalRepo.user().email ?? '',
              style: context.textTheme.labelMedium
                  ?.copyWith(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  c.position() == 0 ? c.currencyFormat.format(c.creditValue.value).toString() : c.currencyFormat.format(c.debitValue.value).toString(),
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold,color: c.position() == 0 ? AppColors.greenClr : AppColors.redClr),
                ),
              ),
              InkWell(
                onTap: () async {
                  await c.logoutWhenComplete();
                },
                child: const Icon(
                  Icons.logout_rounded,
                  size: 24.0,
                ),
              ),
            ],
          ).paddingOnly(right: 12.0),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              tabCategory(context),
              Expanded(
                child: PageView(
                  controller: c.pageCtrl,
                  onPageChanged: (value) {
                    c.position(value);
                  },
                  children: [
                    CreaditTab(),
                    DebitTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(ChooseTypePopup());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0)
        ),
        child: const Icon(Icons.add).paddingAll(12.0),
      ),
    );
  }

  Widget tabCategory(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                c.position(0);
                c.pageCtrl.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      "Credit",
                      style: context.textTheme.labelMedium?.copyWith(
                          color: c.position() == 0
                              ? context.theme.primaryColor
                              : AppColors.blackColor,
                      ),
                    ),
                    Utility.uiSizedBix(12, 0),
                    Container(
                      height: 2.0,
                      color: c.position() == 0
                          ? context.theme.primaryColor
                          : AppColors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                c.position(1);
                c.pageCtrl.animateToPage(1,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn);
              },
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      "Debit",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: c.position() == 1
                            ? context.theme.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Utility.uiSizedBix(12, 0),
                    Container(
                      height: 2.0,
                      color: c.position() == 1
                          ? context.theme.primaryColor
                          : AppColors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
