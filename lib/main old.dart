import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlAppwrite Realtime Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final TextEditingController _nameController = TextEditingController();
  RealtimeSubscription? subscription;
  late final Client client;
  late final Databases database;
  final databaseId = '65106662707571968924';
  final collectionId = '6510667487c988ec57fd';

  @override
  void initState() {
    super.initState();
    client = Client()
            .setEndpoint(
                'http://ec2-15-228-235-228.sa-east-1.compute.amazonaws.com/v1') // your endpoint
            .setProject('651065ade2a67f30b05b') //your project id
        ;
    database = Databases(client);
    login();
    loadItems();
    subscribe();
  }

  login() async {
    try {
      await Account(client).createAnonymousSession();
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  loadItems() async {
    try {
      final res = await database.listDocuments(
          collectionId: collectionId, databaseId: databaseId);
      items.value = RxList<Map<String, dynamic>>.from(
          res.documents.map((e) => e.data).toList());
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  void subscribe() {
    final realtime = Realtime(client);

    subscription = realtime.subscribe(
        ['databases.$databaseId.collections.$collectionId.documents']);

    subscription!.stream.listen((data) {
      for (var ev in data.events) {
        switch (ev) {
          case "databases.*.collections.*.documents.*.create":
            var item = data.payload;
            items.add(item);
            break;
          case "databases.*.collections.*.documents.*.update":
            var item = data.payload;

            for (var it in items) {
              if (it['\$id'] == item['\$id']) {
                it['name'] = item['name'];
              }
            }
            loadItems();
            break;
          case "databases.*.collections.*.documents.*.delete":
            var item = data.payload;
            items.removeWhere((it) => it['\$id'] == item['\$id']);
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Modelo'),
      ),
      body: Obx(() => ListView(children: [
            ...items.map((item) => ListTile(
                  title: Text(item['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await database.deleteDocument(
                        collectionId: collectionId,
                        databaseId: databaseId,
                        documentId: item['\$id'],
                      );
                    },
                  ),
                )),
          ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // dialog to add new item
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add new item'),
              content: TextField(
                controller: _nameController,
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    final name = _nameController.text;
                    if (name.isNotEmpty) {
                      _nameController.clear();
                      _addItem(name);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addItem(String name) async {
    try {
      await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {'name': name},
      );
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }
}
