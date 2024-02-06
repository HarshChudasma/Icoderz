import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_scr_ctrl.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScrCtrl c = Get.put(SplashScrCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Practical Interview",
            style: context.textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
