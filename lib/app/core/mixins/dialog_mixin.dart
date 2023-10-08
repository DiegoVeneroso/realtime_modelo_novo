import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/home/home_controller.dart';
import '../../repositories/home_repositories.dart';

mixin DialogMixin on GetxController {
  void dialogListener(Rxn<DialogModel> dialog) {
    ever<DialogModel?>(dialog, (model) async {
      HomeController controller = HomeController(repository: HomeRepository());
      if (model != null) {
        Get.defaultDialog(
          title: model.title,
          middleText: model.message,
          backgroundColor: Colors.teal,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          confirm: ElevatedButton(
            onPressed: () async {
              await controller.itemDelete(model.id.toString());
            },
            child: const Text('Excluir'),
          ),
          cancel: ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Voltar'),
          ),
        );
      }
    });
  }
}

class DialogModel {
  final String id;
  final String title;
  final String message;

  DialogModel({
    required this.id,
    required this.title,
    required this.message,
  });
}
