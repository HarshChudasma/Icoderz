import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icoderz/firebase_options.dart';
import 'package:icoderz/routes/app_pages.dart';
import 'package:icoderz/routes/app_routes.dart';
import 'package:icoderz/services/prefs_services.dart';
import 'package:icoderz/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PrefService());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Icoderz',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      initialRoute: AppRoutes.SPLASH_SCREEN,
      getPages: AppPages.pagesList,
    );
  }
}