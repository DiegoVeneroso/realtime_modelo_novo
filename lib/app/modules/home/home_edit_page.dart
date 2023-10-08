import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
