import 'package:get/get.dart';
import 'package:icoderz/models/usermodel.dart';
import 'package:icoderz/repo/global_repo.dart';
import 'package:icoderz/routes/app_routes.dart';
import 'package:icoderz/services/prefs_services.dart';

class SplashScrCtrl extends GetxController {

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    Map<String, dynamic>? userData = await prefs.getValue(key: 'userModel');
    3.delay(
          () async {
        if(userData != null){
          globalRepo.user.value = UserModel.fromJson(userData!);
          Get.offAllNamed(AppRoutes.HOME_SCREEN);
        } else {
          return Get.offAllNamed(AppRoutes.LOGIN_SCREEN);
        }

      },
    );
  }

}
