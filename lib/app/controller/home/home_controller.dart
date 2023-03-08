import 'dart:io';

import 'package:float_hello/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class HomeController extends GetxController with WindowListener {
  final isCloseButtonHover = false.obs; // 鼠标是否悬浮于关闭按钮
  final isMaximize = false.obs; // 是否最大化
  final isDarkMode = false.obs; // 是否黑暗模式
  final isChinese = false.obs; // 是否中文模式

  @override
  onInit() {
    if (Platform.isWindows) {
      windowManager.addListener(this);
    }
    isDarkMode.value = Get.isDarkMode;
    isChinese.value = Get.locale == Locale('zh', 'CN');
    super.onInit();
  }

  @override
  onReady() async {
    if (Platform.isWindows) {
      isMaximize.value = await windowManager.isMaximized();
    }
    super.onReady();
  }

  @override
  dispose() {
    if (Platform.isWindows) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  onWindowMaximize() {
    isMaximize.value = true;
  }

  @override
  onWindowUnmaximize() {
    isMaximize.value = false;
  }

  /// 切换最大化显示
  void toggleMaximized() {
    if (!Platform.isWindows) {
      return;
    }

    if (isMaximize.isTrue) {
      windowManager.unmaximize();
    } else {
      windowManager.maximize();
    }
  }

  /// 切换主题
  void toggleThemeMode() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.isTrue ? ThemeMode.dark : ThemeMode.light);

    box.write('isDarkMode', isDarkMode.value);
  }

  /// 切换语言
  void toggleLanguage() {
    isChinese.toggle();
    Get.updateLocale(
        isChinese.isTrue ? Locale('zh', 'CN') : Locale('en', 'US'));

    box.write('isChinese', isChinese.value);
  }

  /// 显示版本信息
  void showVersion() {
    Get.defaultDialog(
      title: 'About'.tr,
      middleText: 'Version'.tr +
          ': ${packageInfo.version}\r\n\r\n'
              'Copyright © 2023 _',
    );
  }
}
