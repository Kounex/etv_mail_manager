import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'etv_mail.freezed.dart';
part 'etv_mail.g.dart';

@freezed
class ETVMail with _$ETVMail {
  factory ETVMail({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    String? $createdAt,
    String? $updatedAt,
    List<String>? $permissions,
    required String address,
    @Default(MailType.available) MailType type,
  }) = _ETVMail;

  factory ETVMail.fromJson(Map<String, dynamic> json) =>
      _$ETVMailFromJson(json);
}

enum MailType {
  available,
  unreachable,
  removed;

  String get name => switch (this) {
        MailType.available => 'Available',
        MailType.unreachable => 'Unreachable',
        MailType.removed => 'Removed',
      };

  Color get color => switch (this) {
        MailType.available => Colors.lightGreen,
        MailType.unreachable => Colors.orangeAccent,
        MailType.removed => Colors.red,
      };
}
