import 'dart:html';

import 'package:etv_mail_manager/utils/env.dart';
import 'package:etv_mail_manager/utils/supabase/table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BaseSupabaseClient {
  static BaseSupabaseClient? _instance;

  BaseSupabaseClient._();

  factory BaseSupabaseClient() {
    /// Trigger an assertion error at client creation if not initialized
    Supabase.instance;

    return _instance ??= BaseSupabaseClient._();
  }

  Session? session() => Supabase.instance.client.auth.currentSession;

  Stream<AuthState> authStream() =>
      Supabase.instance.client.auth.onAuthStateChange;

  Future<Session?> signInWithEmail(String email, String pw) async {
    final result = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: pw,
    );

    return result.session;
  }

  Future<void> resetPasswordForEmail(String email) =>
      Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: EnvUtils().env.redirectURL ??
            '${window.location.protocol}//${window.location.host}/change-password',
      );

  Future<UserResponse> changePassword(
      {required String code, required String password}) async {
    await Supabase.instance.client.auth.exchangeCodeForSession(code);
    return Supabase.instance.client.auth
        .updateUser(UserAttributes(password: password));
  }

  Future<void> signOut() => Supabase.instance.client.auth.signOut();

  Future<T?> get<T>(
    SupabaseTable table,
    String uuid,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final result = await Supabase.instance.client
        .from(table.apiName)
        .select()
        .isFilter('uuid', uuid);

    if (result.isEmpty) {
      return null;
    }

    return fromJson(result.first);
  }

  Future<T?> create<T>(
    SupabaseTable table,
    Map<dynamic, dynamic> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final result = await Supabase.instance.client
        .from(table.apiName)
        .insert(data)
        .select();

    if (result.isEmpty) {
      return null;
    }

    return fromJson(result.first);
  }

  Future<T?> update<T>(
    SupabaseTable table,
    String uuid,
    Map<dynamic, dynamic> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final result = await Supabase.instance.client
        .from(table.apiName)
        .update(data)
        .eq('uuid', uuid)
        .select();

    if (result.isEmpty) {
      return null;
    }

    return fromJson(result.first);
  }

  Future<T?> delete<T>(
    SupabaseTable table,
    String uuid, {
    T Function(Map<String, dynamic> json)? fromJson,
  }) async {
    final result = await Supabase.instance.client
        .from(table.apiName)
        .delete()
        .eq('uuid', uuid)
        .select();

    if (result.isEmpty) {
      return null;
    } else if (fromJson != null) {
      return fromJson(result.first);
    }
    return null;
  }

  Future<List<T>> getAll<T>(SupabaseTable table,
      T Function(Map<String, dynamic> json) fromJson) async {
    final result = await Supabase.instance.client.from(table.apiName).select();

    return List.from(result.map(fromJson));
  }

  Future<List<T?>> createBulk<T>(
    SupabaseTable table,
    List<Map<dynamic, dynamic>> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final results = await _bulk(
      data,
      (element) => BaseSupabaseClient().create(
        table,
        element,
        fromJson,
      ),
    );

    return results;
  }

  Future<List<T?>> updateBulk<T>(
    SupabaseTable table,
    List<(String uuid, Map<dynamic, dynamic> data)> data,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final results = await _bulk(
      data,
      (element) => BaseSupabaseClient().update(
        table,
        element.$1,
        element.$2,
        fromJson,
      ),
    );

    return results;
  }

  Future<List<T?>> deleteBulk<T>(
    SupabaseTable table,
    List<String> uuids,
  ) async {
    return _bulk(
      uuids,
      (uuid) => BaseSupabaseClient().delete(table, uuid),
    );
  }

  Future<List<T>> _bulk<T, R>(
    List<R> elements,
    Future<T> Function(R element) clientAction, {
    int bulkSize = 10,
    Duration bulkDelay = const Duration(seconds: 3),
  }) async {
    Map<int, List<Future<T>>> futures = {};
    for (int i = 0; i < elements.length; i++) {
      futures.putIfAbsent(i ~/ bulkSize, () => []);
      futures[i ~/ bulkSize]!.add(clientAction(elements[i]));
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
