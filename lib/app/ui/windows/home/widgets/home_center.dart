import 'package:float_hello/app/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCenter extends GetView<HomeController> {
  const HomeCenter({super.key});

  @override
  build(context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.receivingCon,
              minLines: 1,
              maxLines: 10,
              readOnly: true,
              decoration: const InputDecoration(
                isDense: true,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.queryCon,
                    decoration: InputDecoration(
                      labelText: 'Send Message'.tr,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: controller.sendQuery,
                  ),
                ),
                IconButton(
                  onPressed: controller.sendQuery,
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
