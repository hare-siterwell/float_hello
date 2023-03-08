import 'package:float_hello/app/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({super.key});

  @override
  build(context) {
    return Drawer();
  }
}
