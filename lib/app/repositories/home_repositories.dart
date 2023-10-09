import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
            .map((docmodel) => ItemModel(
                  id: docmodel.data['id'],
                  name: docmodel.data['name'],
                  image: docmodel.data['image'],
                ))
            .toList();

        return items;
      } else {
        response = await ApiClient.databases.listDocuments(
          databaseId: '65106662707571968924',
          collectionId: '6510667487c988ec57fd',
        );

        var items = response.documents.reversed
            .map((docmodel) => ItemModel(
                  id: docmodel.data['id'],
                  name: docmodel.data['name'],
                  image: docmodel.data['image'],
                ))
            .toList();

        return items;
      }
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  Future deleteImage(String fileId) {
    final response = ApiClient.storage.deleteFile(
      bucketId: constants.itemBucket,
      fileId: fileId,
    );
    return response;
  }

  itemAddRepository(Map map) async {
    try {
      final idUnique = DateTime.now().millisecondsSinceEpoch.toString();

      String fileName = "$idUnique."
          "${map["imagePath"].split(".").last}";

      var urlImage =
          '${constants.API_END_POINT_STORAGE}${constants.itemBucket}/files/$idUnique/view?project=${constants.PROJECT_ID}';

      await ApiClient.storage.createFile(
        bucketId: constants.itemBucket,
        fileId: idUnique,
        file: InputFile(
          path: map["imagePath"],
          filename: fileName,
        ),
      );

      await ApiClient.databases.createDocument(
          databaseId: constants.databaseId,
          collectionId: constants.collectionId,
          documentId: idUnique,
          data: {
            'id': idUnique,
            'name': map["name"],
            'image': urlImage,
          });
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  itemDeleteRepository(String idItem) async {
    try {
      await ApiClient.storage.deleteFile(
        bucketId: constants.itemBucket,
        fileId: idItem,
      );

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
      await ApiClient.storage.deleteFile(
        bucketId: constants.itemBucket,
        fileId: map["id"],
      );

      final idUnique = map["id"];

      String fileName = "$idUnique."
          "${map["imagePath"].split(".").last}";

      var urlImage =
          '${constants.API_END_POINT_STORAGE}${constants.itemBucket}/files/$idUnique/view?project=${constants.PROJECT_ID}';

      await ApiClient.storage.createFile(
        bucketId: constants.itemBucket,
        fileId: idUnique,
        file: InputFile(
          path: map["imagePath"],
          filename: fileName,
        ),
      );

      await ApiClient.databases.updateDocument(
          databaseId: constants.databaseId,
          collectionId: constants.collectionId,
          documentId: map["id"],
          data: {
            'name': map["name"],
            'image': urlImage,
          });
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }
}
