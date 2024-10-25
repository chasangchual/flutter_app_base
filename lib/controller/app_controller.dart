import 'package:app_base/common/preference/app_preference.dart';
import 'package:app_base/common/theme/color/abs_theme_colors.dart';
import 'package:app_base/common/theme/custom_theme.dart';
import 'package:app_base/common/theme/shadows/abs_theme_shadows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxService {
  static AppController get to => Get.find();

  var _extendBody = true.obs;
  var _themeMode = AppPreferences.getValueOrSetDefault(PreferenceItem('$ThemeMode', ThemeMode.light)).obs;

  bool get extendBody => _extendBody.value;

  ThemeMode get themeMode => _themeMode.value;

  set extendBody(bool value) {
    _extendBody.value = value;
  }

  set themeMode(ThemeMode value) {
    _themeMode.value = value;
  }

  AbstractThemeColors get themeColors =>
      _themeMode.value == ThemeMode.light ? CustomTheme.light.appColors : CustomTheme.dark.appColors;

  AbsThemeShadows get themeShowers =>
      _themeMode.value == ThemeMode.light ? CustomTheme.light.appShadows : CustomTheme.dark.appShadows;
}
