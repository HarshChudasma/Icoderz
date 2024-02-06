import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icoderz/database/user_tbl.dart';
import 'package:icoderz/models/usermodel.dart';
import 'package:icoderz/repo/global_repo.dart';
import 'package:icoderz/routes/app_routes.dart';
import 'package:icoderz/services/prefs_services.dart';
import 'package:icoderz/utils/logger.dart';
import 'package:icoderz/utils/utility.dart';

class LoginCtrl extends GetxController {
  RxBool isLoad = false.obs;

  GoogleSignInAccount? googleSignInAccount;

  // Sign In With Google
  Future<UserCredential?> signInWithGoogle() async {
    isLoad(true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        isLoad(false);
        return null; // User cancelled the sign-in process
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.e("Error when login with google : ${e.toString()}");
      Utility.showToast("Something went wrong", Get.context!);
      isLoad(false);
      return null;
    }
  }

  userAlreadyOrNotInDataBase(UserCredential? user) async {
    try {
      UserModel? userFromDB =
          await UserTable.getUserById(userId: user!.user!.uid);
      if (userFromDB != null) {
        globalRepo.user.value = userFromDB;
        prefs.setValue(key: 'userModel', value: userFromDB.toJson());
        Map<String, dynamic>? userData = await prefs.getValue(key: 'userModel');
        isLoad(false);
        Get.offAllNamed(AppRoutes.HOME_SCREEN);
      } else {
        UserModel userModel = UserModel(
            id: user!.user!.uid,
            name: googleSignInAccount!.displayName ?? '',
            email: googleSignInAccount!.email ?? '',
            image: googleSignInAccount!.photoUrl ?? '');
        UserTable.addNewUser(userModel: userModel).then((value) async {
          if (value != 0) {
            globalRepo.user.value =
                (await UserTable.getUserById(userId: user.user!.uid))!;
            await prefs.setValue(
                key: 'userModel', value: globalRepo.user.value.toJson());
            isLoad(false);
            Get.offAllNamed(AppRoutes.HOME_SCREEN);
          }
        });
      }
    } catch (e) {
      logger.e("Error when User Check ${e.toString()}");
      Utility.showToast("Something went wrong", Get.context!);
      isLoad(false);
    }
  }
}
