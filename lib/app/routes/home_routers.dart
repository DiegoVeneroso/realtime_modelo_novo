import 'package:get/get.dart';
import 'package:realtime_modelo/app/modules/home/home_add_page.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_edit_page.dart';
import '../modules/home/home_page.dart';

class HomeRouters {
  HomeRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/home',
      binding: HomeBindings(),
      page: () => HomePage(),
    ),
    GetPage(
      name: '/home_add',
      binding: HomeBindings(),
      page: () => const HomeAddPage(),
    ),
    GetPage(
      name: '/home_edit',
      binding: HomeBindings(),
      page: () => const HomeEditPage(),
    ),
  ];
}
