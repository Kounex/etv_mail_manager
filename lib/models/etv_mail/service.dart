import 'package:signals/signals.dart';

import '../../utils/appwrite_client.dart';
import 'etv_mail.dart';

class ETVMailService {
  static ETVMailService? _instance;

  late final mails = futureSignal(() => getAll(), autoDispose: false);
  final mail = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailAddOrEdit = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailCreateBulk = asyncSignal<List<ETVMail>?>(AsyncState.data(null));
  final mailDelete = asyncSignal<void>(AsyncState.data(null));
  final mailDeleteBulk = asyncSignal<List<void>?>(AsyncState.data(null));

  ETVMailService._();

  factory ETVMailService() => _instance ??= ETVMailService._();

  Future<List<ETVMail>?> getAll() =>
      AppwriteClient().getAll<ETVMail>(ETVMail.fromJson);

  Future<void> get({required String uuid}) async {
    mail.value = AsyncState.loading();
    try {
      final result = await AppwriteClient().get<ETVMail>(
        uuid,
        ETVMail.fromJson,
      );

      mail.value = AsyncState.data(result);
    } catch (e, st) {
      mail.value = AsyncState.error(e, st);
    }
  }

  Future<void> create({required ETVMail mail}) async {
    mailAddOrEdit.value = AsyncState.loading();
    try {
      final result = await AppwriteClient().create<ETVMail>(
        mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
        ETVMail.fromJson,
      );

      mailAddOrEdit.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> createBulk({required List<ETVMail> createMails}) async {
    mailCreateBulk.value = AsyncState.loading();
    try {
      List<ETVMail> result = await AppwriteClient().createBulk(
        List.from(createMails.map((mail) =>
            mail.toJson()..removeWhere((key, value) => key.startsWith('\$')))),
        ETVMail.fromJson,
      );

      mailCreateBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailCreateBulk.value = AsyncState.error(e, st);
    }
  }

  Future<void> update({required ETVMail mail}) async {
    mailAddOrEdit.value = AsyncState.loading();
    try {
      final result = await AppwriteClient().update<ETVMail>(
        mail.$id!,
        mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
        ETVMail.fromJson,
      );

      mailAddOrEdit.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> updateBulk({required List<ETVMail> updateMails}) async {
    mailCreateBulk.value = AsyncState.loading();
    try {
      List<ETVMail> result = await AppwriteClient().updateBulk(
        List.from(
          updateMails.map(
            (mail) => MapEntry(
              mail.$id,
              mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
            ),
          ),
        ),
        ETVMail.fromJson,
      );

      mailCreateBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailCreateBulk.value = AsyncState.error(e, st);
    }
  }

  Future<void> delete({required String uuid}) async {
    mailDelete.value = AsyncState.loading();
    try {
      final result = await AppwriteClient().delete(uuid);

      mailDelete.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailDelete.value = AsyncState.error(e, st);
    }
  }

  Future<void> deleteBulk({required List<ETVMail> deleteMails}) async {
    mailDeleteBulk.value = AsyncState.loading();
    try {
      List<void> result = await AppwriteClient().deleteBulk(
          List.from(List.from(deleteMails.map((mail) => mail.$id))));

      mailDeleteBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailDeleteBulk.value = AsyncState.error(e, st);
    }
  }
}
