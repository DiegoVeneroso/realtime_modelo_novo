import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_modelo/app/modules/home/home_controller.dart';

class HomeAdd extends GetView<HomeController> {
  const HomeAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeAdd'),
      ),
      body: Container(),
    );
  }
}
