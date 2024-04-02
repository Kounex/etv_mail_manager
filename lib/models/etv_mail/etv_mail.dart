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
    CommonReason? commonReason,
    String? reason,
  }) = _ETVMail;

  factory ETVMail.data({
    required String address,
    MailType type = MailType.active,
    CommonReason? commonReason,
    String? reason,
  }) {
    return ETVMail(
      uuid: const Uuid().v4(),
      createdAt: DateTime.now(),
      address: address,
      type: type,
      commonReason: commonReason,
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

enum CommonReason {
  spam,
  notFound,
  leftETV,
  leftBadminton,
  notInterested,
  parent,
  other;

  static List<CommonReason> forType(MailType? type) => [
        ...switch (type) {
          MailType.unreachable => [
              CommonReason.spam,
              CommonReason.notFound,
            ],
          MailType.removed => [
              CommonReason.leftETV,
              CommonReason.leftBadminton,
              CommonReason.notInterested,
              CommonReason.parent,
            ],
          _ => [],
        },
        CommonReason.other,
      ];

  String get text => switch (this) {
        CommonReason.spam => 'Suspected as spam',
        CommonReason.notFound => 'Not found',
        CommonReason.leftETV => 'Left ETV',
        CommonReason.leftBadminton => 'Left Badminton',
        CommonReason.notInterested => 'Not interested in such mails',
        CommonReason.parent => 'Is a parent and doesn\'t want such mails',
        CommonReason.other => 'Other',
      };
}
