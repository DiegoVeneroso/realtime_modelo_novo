import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:realtime_modelo/app/models/item_model.dart';
import '../core/config/api_client.dart';
import '../core/config/constants.dart' as constants;

class HomeRepository {
  RealtimeSubscription? subscription;
  RxList<ItemModel> listItem = <ItemModel>[].obs;
  RxString? search = ''.obs;

  Future<List<ItemModel>> loadDataRepository() async {
    try {
      DocumentList response;
      if (search?.value != '') {
        response = await ApiClient.databases.listDocuments(
          databaseId: '65106662707571968924',
          collectionId: '6510667487c988ec57fd',
          queries: [Query.search("name", search!.value.toString())],
        );
        var items = response.documents.reversed
            .map((docmodel) =>
                ItemModel(id: docmodel.data['id'], name: docmodel.data['name']))
            .toList();

        return items;
      } else {
        response = await ApiClient.databases.listDocuments(
          databaseId: '65106662707571968924',
          collectionId: '6510667487c988ec57fd',
        );

        var items = response.documents.reversed
            .map((docmodel) =>
                ItemModel(id: docmodel.data['id'], name: docmodel.data['name']))
            .toList();

        return items;
      }
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  itemAddRepository(Map map) async {
    try {
      await ApiClient.databases.createDocument(
          databaseId: constants.databaseId,
          collectionId: constants.collectionId,
          documentId: map["id"],
          data: {
            'id': map["id"],
            'name': map["name"],
          });
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  itemDeleteRepository(String idItem) async {
    try {
      await ApiClient.databases.deleteDocument(
        databaseId: constants.databaseId,
        collectionId: constants.collectionId,
        documentId: idItem,
      );
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  itemUpdateRepository(Map map) async {
    try {
      await ApiClient.databases.updateDocument(
          databaseId: constants.databaseId,
          collectionId: constants.collectionId,
          documentId: map["id"],
          data: {
            'name': map["name"],
          });
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }
}
