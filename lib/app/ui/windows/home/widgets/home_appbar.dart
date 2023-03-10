import 'package:float_hello/app/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class HomeAppBar extends GetView<HomeController> {
  const HomeAppBar({super.key});

  @override
  build(context) {
    return AppBar(
      title: Text('Float Hello'.tr),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              value: 'Toggle mode',
              child: Obx(
                () => Text(controller.isDarkMode.isTrue
                    ? 'Switch to light theme'.tr
                    : 'Switch to dark theme'.tr),
              ),
            ),
            PopupMenuItem(
              value: 'Toggle language',
              child: Obx(
                () => Text(controller.isChinese.isTrue
                    ? 'Switch to English'.tr
                    : 'Switch to Chinese'.tr),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              value: 'About',
              child: Text('About'.tr),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'Toggle mode':
                controller.toggleThemeMode();
                break;
              case 'Toggle language':
                controller.toggleLanguage();
                break;
              case 'About':
                controller.showVersion();
                break;
              default:
            }
          },
        ),
        const VerticalDivider(),
        TextButton(
          onPressed: windowManager.minimize,
          child: const Icon(
            Icons.remove,
          ),
        ),
        TextButton(
          onPressed: controller.toggleMaximized,
          child: Obx(
            () => controller.isMaximize.isTrue
                ? const Icon(
                    Icons.filter_none_outlined,
                    size: 14,
                  )
                : const Icon(
                    Icons.crop_square,
                    size: 20,
                  ),
          ),
        ),
        Obx(
          () => TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    controller.isCloseButtonHover.isTrue ? Colors.red : null),
            onPressed: windowManager.close,
            onHover: (value) {
              controller.isCloseButtonHover.value = value;
            },
            child: const Icon(
              Icons.close,
            ),
          ),
        ),
      ],
    );
  }
}
