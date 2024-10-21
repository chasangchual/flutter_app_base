import 'package:app_base/common/preference/app_preference.dart';
import 'package:app_base/common/theme/custom_theme.dart';
import 'package:app_base/controller/main_controller.dart';
import 'package:app_base/main_binding.dart';
import 'package:app_base/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppPreferences.init();

  Get.put(MainController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        initialBinding: MainBindings(),
        home: const MainScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: MainController.to.themeMode,
      );
    });
  }
}
