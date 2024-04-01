import 'package:etv_mail_manager/models/client.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:etv_mail_manager/utils/supabase/table.dart';
import 'package:signals/signals.dart';

import 'etv_mail.dart';

class ETVMailService implements ModelClient<ETVMail> {
  static ETVMailService? _instance;

  final BaseSupabaseClient _client = BaseSupabaseClient();
  final SupabaseTable _table = SupabaseTable.mails;

  final mail = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailAddOrEdit = asyncSignal<ETVMail?>(AsyncState.data(null));
  final mailDelete = asyncSignal<ETVMail?>(AsyncState.data(null));

  late final FutureSignal<List<ETVMail>?> mails;
  final mailCreateBulk = asyncSignal<List<ETVMail?>?>(AsyncState.data(null));
  final mailUpdateBulk = asyncSignal<List<ETVMail?>?>(AsyncState.data(null));
  final mailDeleteBulk = asyncSignal<List<ETVMail?>?>(AsyncState.data(null));

  ETVMailService._() {
    mails = futureSignal(() => getAll(), autoDispose: false);
  }

  factory ETVMailService() => _instance ??= ETVMailService._();

  @override
  Future<void> get(String uuid) async {
    mail.value = AsyncState.loading();
    try {
      final result = await _client.get<ETVMail>(
        _table,
        uuid,
        ETVMail.fromJson,
      );

      mail.value = AsyncState.data(result);
    } catch (e, st) {
      mail.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<void> create(ETVMail mail) async {
    mailAddOrEdit.value = AsyncState.loading();
    try {
      final result = await _client.create<ETVMail>(
        _table,
        mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
        ETVMail.fromJson,
      );

      mailAddOrEdit.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<void> update(ETVMail mail) async {
    mailAddOrEdit.value = AsyncState.loading();
    try {
      final result = await _client.update<ETVMail>(
        _table,
        mail.uuid,
        mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
        ETVMail.fromJson,
      );

      mailAddOrEdit.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<void> delete(String uuid) async {
    mailDelete.value = AsyncState.loading();
    try {
      final result = await _client.delete(
        _table,
        uuid,
      );

      mailDelete.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailDelete.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<List<ETVMail>?> getAll() => _client.getAll<ETVMail>(
        _table,
        ETVMail.fromJson,
      );

  @override
  Future<void> createBulk(List<ETVMail> mailsToCreate) async {
    mailCreateBulk.value = AsyncState.loading();
    try {
      List<ETVMail?> result = await _client.createBulk(
        _table,
        List.from(mailsToCreate.map((mail) =>
            mail.toJson()..removeWhere((key, value) => key.startsWith('\$')))),
        ETVMail.fromJson,
      );

      mailCreateBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailCreateBulk.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<void> updateBulk(List<ETVMail> mailsToUpdate) async {
    mailUpdateBulk.value = AsyncState.loading();
    try {
      List<ETVMail?> result = await _client.updateBulk(
        _table,
        List.from(
          mailsToUpdate.map(
            (mail) => MapEntry(
              mail.uuid,
              mail.toJson()..removeWhere((key, value) => key.startsWith('\$')),
            ),
          ),
        ),
        ETVMail.fromJson,
      );

      mailUpdateBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailUpdateBulk.value = AsyncState.error(e, st);
    }
  }

  @override
  Future<void> deleteBulk(List<ETVMail> mailsToDelete) async {
    mailDeleteBulk.value = AsyncState.loading();
    try {
      List<ETVMail?> result = await _client.deleteBulk(
        _table,
        List.from(
          List.from(
            mailsToDelete.map((mail) => mail.uuid),
          ),
        ),
      );

      mailDeleteBulk.value = AsyncState.data(result);
      mails.refresh();
    } catch (e, st) {
      mailDeleteBulk.value = AsyncState.error(e, st);
    }
  }
}
