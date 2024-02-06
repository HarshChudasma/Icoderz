import 'package:get/get.dart';
import 'package:icoderz/models/usermodel.dart';

final globalRepo = Get.put(GlobalRepo(), permanent: true);

class GlobalRepo extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
  }
}