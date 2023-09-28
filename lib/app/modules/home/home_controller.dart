import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:realtime_modelo/app/core/config/api_client.dart';
import 'package:realtime_modelo/app/models/item_model.dart';
import '../../core/config/constants.dart' as constants;
import '../../core/mixins/loader_mixin.dart';
import '../../core/mixins/messages_mixin.dart';

class HomeController extends GetxController with LoaderMixin, MessagesMixin {
  RealtimeSubscription? subscription;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  RxList<ItemModel> listItem = <ItemModel>[].obs;

  @override
  onInit() {
    loaderListener(_loading);
    messageListener(_message);
    login();
    subscribe();
    loadItems();
    super.onInit();
  }

  login() async {
    try {
      // _loading.toggle();
      await ApiClient.account.createAnonymousSession();
    } on AppwriteException catch (e) {
      // _loading.toggle();
      print(e.message);
    }
  }

  Future<List<ItemModel>> loadItems() async {
    try {
      final res = await ApiClient.databases.listDocuments(
          collectionId: constants.collectionId,
          databaseId: constants.databaseId);

      listItem.value = List<ItemModel>.from(res.documents
          .map((e) => ItemModel(name: e.data['name'].toString()))
          .toList());
      return listItem;
      // var teste = List<ItemModel>.from(res.documents
      //     .map((e) => ItemModel(name: e.data['name'].toString()))
      //     .toList());
      // return teste;
    } on AppwriteException catch (e) {
      _loading.toggle();
      print(e.message);
      throw ();
    }

    // Future.delayed(const Duration(seconds: 2));
    // return [
    //   ItemModel(name: 'fasdf'),
    //   ItemModel(name: 'fddd'),
    //   ItemModel(name: 'fasddddf'),
    //   ItemModel(name: 'fasddddf'),
    // ];
  }

  // loadItems() async {
  //   try {
  //     // _loading.toggle();
  //     final res = await ApiClient.databases.listDocuments(
  //         collectionId: constants.collectionId,
  //         databaseId: constants.databaseId);
  //     items.value = RxList<Map<String, dynamic>>.from(
  //         res.documents.map((e) => e.data).toList());
  //   } on AppwriteException catch (e) {
  //     _loading.toggle();
  //     print(e.message);
  //   }
  // }

  void subscribe() {
    final realtime = Realtime(ApiClient.account.client);

    subscription = realtime.subscribe([
      'databases.${constants.databaseId}.collections.${constants.collectionId}.documents'
    ]);

    subscription!.stream.listen((data) {
      for (var ev in data.events) {
        switch (ev) {
          case "databases.*.collections.*.documents.*.create":
            print(data.payload);
            listItem.add(ItemModel(name: data.payload['name']));
            // items.add(item);

            loadItems();
            break;
          case "databases.*.collections.*.documents.*.update":
            var item = data.payload;

            // for (var it in items) {
            //   if (it['\$id'] == item['\$id']) {
            //     it['name'] = item['name'];
            //   }
            // }
            loadItems();
            break;
          case "databases.*.collections.*.documents.*.delete":
            var item = data.payload;
            // items.removeWhere((it) => it['\$id'] == item['\$id']);
            loadItems();

            break;
          default:
            break;
        }
      }
    });
  }
}
