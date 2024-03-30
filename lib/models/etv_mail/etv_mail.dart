import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'etv_mail.freezed.dart';
part 'etv_mail.g.dart';

@freezed
class ETVMail with _$ETVMail {
  factory ETVMail({
    required String uuid,
    required DateTime createdAt,
    required String address,
    @Default(MailType.active) MailType type,
    String? reason,
  }) = _ETVMail;

  factory ETVMail.data({
    required String address,
    MailType type = MailType.active,
    String? reason,
  }) {
    return ETVMail(
      uuid: const Uuid().v4(),
      createdAt: DateTime.now(),
      address: address,
      type: type,
      reason: reason,
    );
  }

  factory ETVMail.fromJson(Map<String, dynamic> json) =>
      _$ETVMailFromJson(json);
}

enum MailType {
  active,
  unreachable,
  removed;

  String get name => switch (this) {
        MailType.active => 'Active',
        MailType.unreachable => 'Unreachable',
        MailType.removed => 'Removed',
      };

  Color get color => switch (this) {
        MailType.active => Colors.lightGreen,
        MailType.unreachable => Colors.orangeAccent,
        MailType.removed => Colors.red,
      };
}
