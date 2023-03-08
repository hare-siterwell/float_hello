import 'package:float_hello/app/bindings/home_binding.dart';
import 'package:float_hello/app/routes/app_routes.dart';
import 'package:float_hello/app/ui/windows/home/home_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
