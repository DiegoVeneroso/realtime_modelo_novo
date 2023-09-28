import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_modelo/app/models/item_model.dart';
import 'package:realtime_modelo/app/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Modelo'),
      ),
      body: Obx(
        () => FutureBuilder(
            future: controller.loadItems(),
            // future: Future(() => controller.listItem),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Não tem registro!',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  )),
                );
              }

              var dataSnapshot =
                  snapshot.data?.map((e) => ItemModel(name: e.name)).toList();

              return ListView.builder(
                itemCount: dataSnapshot!.length,
                itemBuilder: (ctx, index) {
                  return Text(
                    dataSnapshot[index].name,
                    style: const TextStyle(color: Colors.black),
                  );
                },
              );
            }),
      ),
    );
  }
}
