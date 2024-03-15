import 'package:appwrite/appwrite.dart';

const String cloudEndpoint = 'https://cloud.appwrite.io/v1';
const String cloudProjectId = '65f0b91a62f4eb9c8fa2';
const String cloudDatabaseId = '65f0bcc6a53aa23bc084';
const String cloudMailCollectionId = '65f0bcd5d214aecbf36c';

const String gitpodEndpoint =
    'https://8080-appwrite-integrationfor-rszefxwlkso.ws-eu110.gitpod.io/v1';
const String gitpodProjectId = '65f49cd8cf38b1a700e2';
const String gitpodDatabaseId = '65f49cfe2fbc45c5d2e5';
const String gitpodMailCollectionId = '65f49d0581730904ae13';

class AppwriteClient {
  static AppwriteClient? _instance;

  final String _endpoint = gitpodEndpoint;
  final String _projectId = gitpodProjectId;
  final String _databaseId = gitpodDatabaseId;
  final String _mailCollectionId = gitpodMailCollectionId;

  late final Client client;
  late final Databases databases;

  AppwriteClient._() {
    this.client = Client()
        .setEndpoint(_endpoint)
        .setProject(_projectId)
        .setSelfSigned(status: true);

    this.databases = Databases(this.client);
  }

  factory AppwriteClient() => _instance ??= AppwriteClient._();

  Future<List<T>> getAll<T>(T Function(Map<String, dynamic> json) fromJson,
      {List<String>? queries}) async {
    final documentList = await this.databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _mailCollectionId,
      queries: [
        Query.limit(400),
        ...queries ?? [],
      ],
    );

    return documentList.convertTo<T>(
      (json) => fromJson(json as Map<String, dynamic>),
    );
  }

  Future<T> get<T>(
      String documentId, T Function(Map<String, dynamic> json) fromJson,
      {List<String>? queries}) async {
    final document = await this.databases.getDocument(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          documentId: documentId,
          queries: queries,
        );

    return document.convertTo<T>(
      (json) => fromJson(json as Map<String, dynamic>),
    );
  }

  Future<T> create<T>(
    Map<dynamic, dynamic> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final result = await AppwriteClient().databases.createDocument(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          documentId: ID.unique(),
          data: data,
        );

    return result.convertTo(
      (json) => fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<T>> createBulk<T>(
    List<Map<dynamic, dynamic>> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final results = await _bulk(
      data,
      (element) => AppwriteClient().databases.createDocument(
            databaseId: _databaseId,
            collectionId: _mailCollectionId,
            documentId: ID.unique(),
            data: element,
          ),
    );

    return List.from(
      results.map(
        (result) => result.convertTo(
          (json) => fromJson(json as Map<String, dynamic>),
        ),
      ),
    );
  }

  Future<T> update<T>(
    String uuid,
    Map<dynamic, dynamic> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final result = await AppwriteClient().databases.updateDocument(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          documentId: uuid,
          data: data,
        );

    return result.convertTo(
      (json) => fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<T>> updateBulk<T>(
    List<MapEntry<String, Map<dynamic, dynamic>>> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final results = await _bulk(
      data,
      (element) => AppwriteClient().databases.updateDocument(
            databaseId: _databaseId,
            collectionId: _mailCollectionId,
            documentId: element.key,
            data: element.value,
          ),
    );

    return List.from(
      results.map(
        (result) => result.convertTo(
          (json) => fromJson(json as Map<String, dynamic>),
        ),
      ),
    );
  }

  Future<void> delete(String uuid) {
    return AppwriteClient().databases.deleteDocument(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          documentId: uuid,
        );
  }

  Future<List<void>> deleteBulk<T>(List<String> uuids) async {
    return _bulk(
      uuids,
      (uuid) => AppwriteClient().databases.deleteDocument(
            databaseId: _databaseId,
            collectionId: _mailCollectionId,
            documentId: uuid,
          ),
    );
  }

  Future<List<T>> _bulk<T, R>(
    List<R> elements,
    Future<T> Function(R element) appwriteAction, {
    int bulkSize = 10,
    Duration bulkDelay = const Duration(seconds: 3),
  }) async {
    Map<int, List<Future<T>>> futures = {};
    for (int i = 0; i < elements.length; i++) {
      futures.putIfAbsent(i ~/ bulkSize, () => []);
      futures[i ~/ bulkSize]!.add(appwriteAction(elements[i]));
    }

    List<List<T>> results = [];
    for (final key in futures.keys) {
      results.add(await Future.wait<T>(futures[key]!));
      await Future.delayed(bulkDelay);
    }

    return results.fold<List<T>>(
      [],
      (prev, curr) => [
        ...prev,
        ...curr,
      ],
    );
  }
}
