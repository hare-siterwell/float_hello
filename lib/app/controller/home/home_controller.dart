import 'dart:io';

import 'package:float_hello/app/controller/method/user_provider.dart';
import 'package:float_hello/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';

class HomeController extends GetxController with WindowListener {
  final isCloseButtonHover = false.obs; // 鼠标是否悬浮于关闭按钮
  final isMaximize = false.obs; // 是否最大化
  final isDarkMode = false.obs; // 是否黑暗模式
  final isChinese = false.obs; // 是否中文模式

  final apiKeyCon = TextEditingController();
  final secretKeyCon = TextEditingController();
  final accessTokenCon = TextEditingController();
  final queryCon = TextEditingController();
  final receivingCon = TextEditingController();
  final webViewCon = WebviewController();

  @override
  onInit() {
    if (Platform.isWindows) {
      windowManager.addListener(this);
    }
    isDarkMode.value = Get.isDarkMode;
    isChinese.value = Get.locale == const Locale('zh', 'CN');

    apiKeyCon.text = box.read('apiKeyCon') ?? '';
    secretKeyCon.text = box.read('secretKeyCon') ?? '';
    accessTokenCon.text = box.read('accessTokenCon') ?? '';
    initWebState();
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
  onClose() {
    if (Platform.isWindows) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  void initWebState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await webViewCon.initialize();
      await webViewCon
          .loadUrl('https://8560p5kej.wasee.com/s/8560p5kej?def_sid=0');
      webViewCon.webMessage.listen((event) {});
    } on Exception catch (e) {
      print(e);
    }
  }

  /// 获取Access_token
  void getAccessToken() async {
    final apiKey = apiKeyCon.text;
    final secretKey = secretKeyCon.text;

    final url = 'https://aip.baidubce.com/oauth/2.0/token?client_id=$apiKey&'
        'client_secret=$secretKey&grant_type=client_credentials';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final response = await UserProvider().postUser(url, {}, headers: headers);

    accessTokenCon.text = response.body['access_token'] ?? '';

    box.write('apiKeyCon', apiKeyCon.text);
    box.write('secretKeyCon', secretKeyCon.text);
    box.write('accessTokenCon', accessTokenCon.text);
  }

  /// 发送查询
  void sendQuery() async {
    final accessToken = accessTokenCon.text;
    final query = queryCon.text;

    final url =
        'https://aip.baidubce.com/rpc/2.0/unit/service/v3/chat?access_token='
        '$accessToken';

    final postData = {
      "version": "3.0",
      "service_id": "S82756",
      "session_id": "",
      "log_id": "7758521",
      "request": {"terminal_id": "88888", "query": query}
    };

    final headers = {'content-type': 'application/json'};

    receivingCon.text = 'Loading...'.tr;

    final response =
        await UserProvider().postUser(url, postData, headers: headers);

    receivingCon.text =
        response.body['result']?['responses']?[0]?['actions']?[0]?['say'] ?? '';
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
        isChinese.isTrue ? const Locale('zh', 'CN') : const Locale('en', 'US'));

    box.write('isChinese', isChinese.value);
  }

  /// 显示版本信息
  void showVersion() {
    Get.defaultDialog(
      title: 'About'.tr,
      middleText: '${'Version'.tr}: ${packageInfo.version}\r\n\r\n'
          'Copyright © 2023 _',
    );
  }
}
