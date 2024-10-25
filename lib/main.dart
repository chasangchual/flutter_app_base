import 'package:app_base/common/preference/app_preference.dart';
import 'package:app_base/common/theme/custom_theme.dart';
import 'package:app_base/controller/app_controller.dart';
import 'package:app_base/main_binding.dart';
import 'package:app_base/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// `WidgetsFlutterBinding` serves as a concrete binding for applications built on the Widgets framework.
/// It acts as the interface that connects the Flutter framework to the Flutter engine.
/// Initializing `WidgetsFlutterBinding` by calling `ensureInitialized()` is essential to facilitate communication
/// between the framework and the engine.
/// For more details, refer to the Flutter architectural layers diagram:
/// (https://docs.flutter.dev/resources/architectural-overview#architectural-layers)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();

  Get.put(AppController());

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
        themeMode: AppController.to.themeMode,
      );
    });
  }
}
