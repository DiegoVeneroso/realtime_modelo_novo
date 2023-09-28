import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';

class SplashRouters {
  SplashRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/',
      binding: SplashBinding(),
      page: () => const SplashPage(),
    )
  ];
}
