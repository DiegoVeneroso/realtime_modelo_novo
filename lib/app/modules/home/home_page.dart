import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:realtime_modelo/app/core/ui/widgets/custom_drawer.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  RxBool searchVisible = false.obs;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Realtime modelo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => searchVisible.toggle(),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Visibility(
              visible: searchVisible.value,
              child: const SizedBox(
                height: 20,
              ),
            ),
            Obx(
              () => Visibility(
                visible: searchVisible.value,
                child: TextField(
                  onChanged: (value) => controller.filterItem(value),
                  decoration: InputDecoration(
                    labelText: 'Pesquisar',
                    suffixIcon: IconButton(
                        onPressed: () => searchVisible.toggle(),
                        icon: const Icon(Icons.close)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.foundItem.value.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 60,
                                margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    controller.foundItem.value[index].image,
                                    width: 100,
                                    height: 60,
                                    fit: BoxFit.fill,
                                    // color: AppColor.purpleColor,
                                    colorBlendMode: BlendMode.color,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .foundItem.value[index].name,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          controller.itemList[index].id
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.getDialog(
                                            idItem: controller
                                                .itemList[index].id
                                                .toString(),
                                            item: controller
                                                .foundItem.value[index].name);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed('/home_edit', parameters: {
                                          'name': controller
                                              .itemList[index].name
                                              .toString(),
                                          'id': controller.itemList[index].id
                                              .toString(),
                                          'image': controller
                                              .itemList[index].image
                                              .toString(),
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.grey[200],
                            height: 2,
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home_add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
