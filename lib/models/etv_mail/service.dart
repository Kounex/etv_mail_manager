import 'package:signals/signals.dart';

import '../../utils/appwrite_client.dart';
import 'etv_mail.dart';

class ETVMailService {
  static ETVMailService? _instance;

  late final mails = futureSignal(() => getAll(), autoDispose: false);
  final mail = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailAddOrEdit = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailDelete = asyncSignal<void>(AsyncState.data(null));

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
}
