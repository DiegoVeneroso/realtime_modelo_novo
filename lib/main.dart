import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/home_routers.dart';
import 'app/routes/splash_routers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: 'Auth_appwrite',
      debugShowCheckedModeBanner: false,
      getPages: [
        ...SplashRouters.routers,
        ...HomeRouters.routers,
      ],
    ),
  );
}
