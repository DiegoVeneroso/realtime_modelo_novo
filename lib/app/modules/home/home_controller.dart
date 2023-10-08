// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:realtime_modelo/app/core/config/api_client.dart';
import 'package:realtime_modelo/app/core/mixins/dialog_mixin.dart';
import 'package:realtime_modelo/app/models/item_model.dart';
import 'package:realtime_modelo/app/repositories/home_repositories.dart';

import '../../core/config/constants.dart' as constants;
import '../../core/mixins/loader_mixin.dart';
import '../../core/mixins/messages_mixin.dart';

class HomeController extends GetxController
    with LoaderMixin, MessagesMixin, DialogMixin {
  RealtimeSubscription? subscription;
  HomeRepository repository;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  final _dialog = Rxn<DialogModel>();
  var ItemList = <ItemModel>[].obs;

  Rx<List<ItemModel>> foundItem = Rx<List<ItemModel>>([]);

  HomeController({
    required this.repository,
  });

  @override
  onInit() {
    loaderListener(_loading);
    messageListener(_message);
    dialogListener(_dialog);
    foundItem.value = ItemList;

    super.onInit();
  }

  @override
  onReady() {
    login();

    subscribe();
    loadData();
    super.onReady();
  }

  getDialog({
    required String idItem,
    required String item,
  }) {
    _dialog(DialogModel(
      id: idItem,
      title: 'Atenção',
      message: 'Deseja realmente excluir o item?\n$item',
    ));
  }

  void filterItem(String ItemName) {
    List<ItemModel> results = [];
    if (ItemName.isEmpty) {
      results = ItemList;
    } else {
      results = ItemList.where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(ItemName.toLowerCase())).toList();
    }
    foundItem.value = results;
  }

  login() async {
    try {
      _loading.toggle();
      await ApiClient.account.createAnonymousSession();
      print('usuario anonimo logado!');
    } on AppwriteException catch (e) {
      _loading.toggle();
      print(e.message);
    }
  }

  void loadData() async {
    try {
      _loading.toggle();
      var dataRepository = await repository.loadDataRepository();

      ItemList.assignAll(dataRepository);
    } finally {
      _loading.toggle();
    }
  }

  void subscribe() {
    final realtime = Realtime(ApiClient.account.client);

    subscription = realtime.subscribe([
      'databases.${constants.databaseId}.collections.${constants.collectionId}.documents'
    ]);

    subscription!.stream.listen((data) {
      for (var ev in data.events) {
        switch (ev) {
          case "databases.*.collections.*.documents.*.create":
            // var item = data.payload;
            // ItemList.add(ItemModel(name: item['name']));
            loadData();
            break;
          case "databases.*.collections.*.documents.*.update":
            // var items = data.payload;
            // print('id2');
            // print(items['\$id']);

            // items.forEach((key, value) {
            //   print('key[2]');
            //   print(key);

            //   print('value[' '');
            //   print(value);
            // });

            // for (var it in items) {
            //   print('id');
            //   print(it.toString());
            //   // if (int.parse(it['\$id']) == items['\$id']) {
            //   //   it['name'] = items['name'];
            //   // }
            // }
            loadData();

            break;
          case "databases.*.collections.*.documents.*.delete":
            // var item = data.payload;

            // print('item');
            // print(item['\$id']);
            // ItemList.removeWhere((it) => it.id == item['\$id']);
            loadData();

            break;
          default:
            break;
        }
      }
    });
  }

  Future<void> itemAdd(Map map) async {
    try {
      _loading.toggle();

      await repository.itemAddRepository(map);

      await Future.delayed(const Duration(seconds: 1));
      _loading.toggle();
      Get.offAndToNamed('/home');
      _message(
        MessageModel(
          title: 'Parabéns!',
          message: 'Item adicionado com sucesso!',
          type: MessageType.success,
        ),
      );
    } catch (e) {
      print(e.toString());

      _message(
        MessageModel(
          title: 'Atenção!',
          message: e.toString(),
          type: MessageType.error,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      _loading.toggle();
      Get.offAndToNamed('/home');
    }
  }

  Future itemDelete(String idItem) async {
    try {
      Get.back();
      _loading.toggle();

      await repository.itemDeleteRepository(idItem);

      _loading.toggle();
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(
        'Atenção!',
        'Item excluído com sucesso!',
        backgroundColor: Colors.red[800]!,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
      );
    } catch (e) {
      print(e.toString());

      _message(
        MessageModel(
          title: 'Atenção!',
          message: e.toString(),
          type: MessageType.error,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      _loading.toggle();
      Get.offAndToNamed('/home');
    }
  }

  Future<void> itemUpdate(Map map) async {
    try {
      _loading.toggle();

      await repository.itemUpdateRepository(map);

      await Future.delayed(const Duration(seconds: 1));
      _loading.toggle();
      Get.offAndToNamed('/home');
      _message(
        MessageModel(
          title: 'Parabéns!',
          message: 'Item atualizado com sucesso!',
          type: MessageType.success,
        ),
      );
    } catch (e) {
      print(e.toString());

      _message(
        MessageModel(
          title: 'Atenção!',
          message: e.toString(),
          type: MessageType.error,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      _loading.toggle();
      Get.offAndToNamed('/home');
    }
  }
}
