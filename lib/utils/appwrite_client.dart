import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  static AppwriteClient? _instance;
  final String _databaseId = '65f0bcc6a53aa23bc084';
  final String _mailCollectionId = '65f0bcd5d214aecbf36c';

  late final Client client;
  late final Databases databases;

  AppwriteClient._() {
    this.client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('65f0b91a62f4eb9c8fa2')
        .setSelfSigned(status: true);

    this.databases = Databases(this.client);
  }

  factory AppwriteClient() => _instance ??= AppwriteClient._();

  Future<List<T>> getAll<T>(T Function(Map<String, dynamic> json) fromJson,
      {List<String>? queries}) async {
    final documentList = await this.databases.listDocuments(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          queries: queries,
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

  Future<void> delete(String uuid) {
    return AppwriteClient().databases.deleteDocument(
          databaseId: _databaseId,
          collectionId: _mailCollectionId,
          documentId: uuid,
        );
  }
}
