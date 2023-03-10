import 'dart:io';

import 'package:float_hello/app/routes/app_pages.dart';
import 'package:float_hello/app/routes/app_routes.dart';
import 'package:float_hello/app/translations/app_translations.dart';
import 'package:float_hello/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

late final PackageInfo packageInfo;
late final GetStorage box;

Future<void> main() async {
  packageInfo = await PackageInfo.fromPlatform();
  await GetStorage.init(packageInfo.packageName);
  box = GetStorage(packageInfo.packageName);
  final isDarkMode = box.read('isDarkMode') ?? (Get.isPlatformDarkMode);
  final isChinese =
      box.read('isChinese') ?? (Get.deviceLocale.toString().contains('_CN'));

  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    const defaultWindowSize = Size(800, 600);
    WindowOptions windowOptions = const WindowOptions(
      size: defaultWindowSize,
      minimumSize: defaultWindowSize,
      titleBarStyle: TitleBarStyle.hidden,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(
    GetMaterialApp(
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
      theme: appThemeData,
      darkTheme: appDarkThemeData,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      defaultTransition: Transition.fade,
      locale: isChinese ? const Locale('zh', 'CN') : const Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
    ),
  );
}
