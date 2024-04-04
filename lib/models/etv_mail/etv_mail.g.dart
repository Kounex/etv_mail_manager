// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etv_mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ETVMailImpl _$$ETVMailImplFromJson(Map<String, dynamic> json) =>
    _$ETVMailImpl(
      uuid: json['uuid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      address: json['address'] as String,
      type: $enumDecodeNullable(_$MailTypeEnumMap, json['type']) ??
          MailType.active,
      commonReason:
          $enumDecodeNullable(_$CommonReasonEnumMap, json['commonReason']),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$ETVMailImplToJson(_$ETVMailImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'createdAt': instance.createdAt.toIso8601String(),
      'address': instance.address,
      'type': _$MailTypeEnumMap[instance.type]!,
      'commonReason': _$CommonReasonEnumMap[instance.commonReason],
      'reason': instance.reason,
    };

const _$MailTypeEnumMap = {
  MailType.active: 'active',
  MailType.unreachable: 'unreachable',
  MailType.removed: 'removed',
};

const _$CommonReasonEnumMap = {
  CommonReason.spam: 'spam',
  CommonReason.notFound: 'notFound',
  CommonReason.full: 'full',
  CommonReason.leftETV: 'leftETV',
  CommonReason.leftBadminton: 'leftBadminton',
  CommonReason.notInterested: 'notInterested',
  CommonReason.parent: 'parent',
  CommonReason.other: 'other',
};
