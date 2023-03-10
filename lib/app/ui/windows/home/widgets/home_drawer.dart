import 'package:float_hello/app/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({super.key});

  @override
  build(context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.apiKeyCon,
              decoration: InputDecoration(
                labelText: 'API KEY',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.secretKeyCon,
              decoration: InputDecoration(
                labelText: 'Secret KEY',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.getAccessToken,
              child: Text('Get Access_token'.tr),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.accessTokenCon,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Access_token',
                isDense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
