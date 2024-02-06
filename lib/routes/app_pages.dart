import 'package:get/get.dart';
import 'package:icoderz/modules/details_screen/details_scr.dart';
import 'package:icoderz/modules/home_screen/home_scr.dart';
import 'package:icoderz/modules/login_screen/login_scr.dart';
import 'package:icoderz/modules/splash_screen/splash_screen.dart';
import 'package:icoderz/routes/app_routes.dart';

class AppPages {
  static List<GetPage> pagesList = [
    GetPage(name: AppRoutes.SPLASH_SCREEN, page: () => SplashScreen(),),
    GetPage(name: AppRoutes.LOGIN_SCREEN, page: () => LoginScreen(),),
    GetPage(name: AppRoutes.HOME_SCREEN, page: () => HomeScreen(),),
    GetPage(name: AppRoutes.DETAILS_SCREEN, page: () => DetailsScreen(),),
  ];

}