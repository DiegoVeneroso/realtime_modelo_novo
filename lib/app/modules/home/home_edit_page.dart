import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/app_state.dart';
import '../../core/ui/widgets/custom_button.dart';
import '../../core/ui/widgets/custom_textformfield.dart';
import 'home_controller.dart';

class HomeEditPage extends StatefulWidget {
  const HomeEditPage({Key? key}) : super(key: key);

  @override
  State<HomeEditPage> createState() => _HomeAddPageState();
}

class _HomeAddPageState extends AppState<HomeEditPage, HomeController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController(text: Get.parameters['name']);

  @override
  void dispose() {
    _nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Realtime modelo'),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Atualizar item',
                        style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.imageFile == null
                        ? Center(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  Get.parameters['image'].toString()),
                              backgroundColor: Colors.black,
                            ),
                          )
                        : Center(
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: FileImage(
                                      File(controller.imageFile!.path),
                                    ),
                                  )),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await controller.pickImageFileFromGalery();
                            setState(() {
                              controller.imageFile;
                            });
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () async {
                            await controller.captureImageFileFromCamera();
                            setState(() {
                              controller.imageFile;
                            });
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    CustomTextformfield(
                      label: 'Nome',
                      controller: _nameEC,
                      validator: Validatorless.required('Nome Obrigatório'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomButton(
                        width: double.infinity,
                        label: 'ATUALIZAR',
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            controller.itemUpdate({
                              'id': Get.parameters['id'],
                              'name': _nameEC.text,
                              'imagePath': controller.imageFile == null
                                  ? ''
                                  : controller.imageFile!.path,
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CustomButton(
                        width: double.infinity,
                        label: 'VOLTAR',
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
