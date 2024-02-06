import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/modules/login_screen/login_ctrl.dart';
import 'package:icoderz/utils/constants/image_const.dart';
import 'package:icoderz/utils/utility.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginCtrl c = Get.put(LoginCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Icoderz Solutions",
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.theme.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Utility.uiSizedBix(20, 0),
              Text(
                "Welcome",
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Utility.uiSizedBix(context.height / 4, 0),
              ElevatedButton(
                onPressed: () async {
                  UserCredential? user = await c.signInWithGoogle();
                  if(user != null){
                    c.userAlreadyOrNotInDataBase(user);
                  } else {
                    Utility.showToast("Something went wrong", context);
                  }

                },
                child: Obx(
                  () => c.isLoad() ? Center(
                    child: CircularProgressIndicator().paddingAll(6.0),
                  ) : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ImageConst.googleImage, // Replace with the path to your Google logo asset
                          height: 24.0,
                        ),
                        Utility.uiSizedBix(0, 12),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ).paddingSymmetric(vertical: 24.0,horizontal: 24.0),
        ),
      ),
    );
  }
}
