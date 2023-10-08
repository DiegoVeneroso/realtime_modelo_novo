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
                                    'https://burst.shopifycdn.com/photos/wrist-watches.jpg',
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
                                          controller.ItemList[index].id
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
                                                .ItemList[index].id
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
                                              .ItemList[index].name
                                              .toString(),
                                          'id': controller.ItemList[index].id
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





// import 'package:animated_search_bar/animated_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:realtime_modelo/app/modules/home/home_controller.dart';
// import 'package:realtime_modelo/app/repositories/home_repositories.dart';

// class HomePage extends GetView<HomeController> {
//   HomePage({Key? key}) : super(key: key);
//   HomeRepository repository = HomeRepository();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Realtime modelo'),
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.toNamed('/home_search'),
        //     icon: const Icon(Icons.search),
        //   ),
        // ],
//       ),
//       body: Obx(() {
//         return controller.ItemList.isEmpty
//             ? const Center(
//                 child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     color: Colors.red,
//                   )
//                 ],
//               ))
//             : ListView.builder(
//                 itemCount: controller.ItemList.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: <Widget>[
//                       Row(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 60,
//                             margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.network(
//                                 'https://burst.shopifycdn.com/photos/wrist-watches.jpg',
//                                 width: 100,
//                                 height: 60,
//                                 fit: BoxFit.fill,
//                                 // color: AppColor.purpleColor,
//                                 colorBlendMode: BlendMode.color,
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: Row(
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       controller.ItemList[index].name
//                                           .toString(),
//                                       style: const TextStyle(fontSize: 18),
//                                     ),
//                                     Text(
//                                       controller.ItemList[index].id.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     controller.itemDelete(controller
//                                         .ItemList[index].id
//                                         .toString());
//                                   },
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     Get.toNamed('/home_edit', parameters: {
//                                       'name': controller.ItemList[index].name
//                                           .toString(),
//                                       'id': controller.ItemList[index].id
//                                           .toString(),
//                                     });
//                                   },
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         color: Colors.grey[200],
//                         height: 2,
//                       ),
//                     ],
//                   );
//                 },
//               );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.toNamed('/home_add');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
