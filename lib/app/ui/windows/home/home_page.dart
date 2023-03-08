import 'dart:io';

import 'package:float_hello/app/controller/home/home_controller.dart';
import 'package:float_hello/app/ui/theme/app_preferred_size.dart';
import 'package:float_hello/app/ui/windows/home/widgets/home_appbar.dart';
import 'package:float_hello/app/ui/windows/home/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  build(context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(homeAppBarHeight),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (details) {
            if (Platform.isWindows) {
              windowManager.startDragging();
            }
          },
          onDoubleTap: controller.toggleMaximized,
          child: HomeAppBar(),
        ),
      ),
      body: Center(
        child: Text('Hello World!'.tr),
      ),
      drawer: HomeDrawer(),
    );
  }
}
