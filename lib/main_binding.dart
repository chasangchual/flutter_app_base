import 'package:app_base/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
