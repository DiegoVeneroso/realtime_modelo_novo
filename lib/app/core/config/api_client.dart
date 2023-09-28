// libs/api/client.dart

import 'package:appwrite/appwrite.dart';
import '../config/constants.dart' as constants;

class ApiClient {
  Client get _client {
    Client client = Client();

    client
        .setEndpoint(constants.API_END_POINT)
        .setProject(constants.PROJECT_ID)
        .setLocale('pt-br')
        .setSelfSigned(status: false);

    return client;
  }

  static Account get account => Account(_instance._client);
  static Databases get databases => Databases(_instance._client);
  static Storage get storage => Storage(_instance._client);

  static final ApiClient _instance = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instance;
}
