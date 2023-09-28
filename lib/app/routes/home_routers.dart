import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';

class HomeRouters {
  HomeRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/home',
      binding: HomeBindings(),
      page: () => const HomePage(),
    ),
  ];
}
