import 'package:get/get.dart';

class MainController extends GetxService {
  static MainController get to => Get.find();

  var _extendBody = true.obs;

  bool get extendBody => _extendBody.value;

  set extendBody(bool value) {
    _extendBody.value = value;
  }
}
