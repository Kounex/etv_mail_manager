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
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$ETVMailImplToJson(_$ETVMailImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'createdAt': instance.createdAt.toIso8601String(),
      'address': instance.address,
      'type': _$MailTypeEnumMap[instance.type]!,
      'reason': instance.reason,
    };

const _$MailTypeEnumMap = {
  MailType.active: 'active',
  MailType.unreachable: 'unreachable',
  MailType.removed: 'removed',
};
