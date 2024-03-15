// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etv_mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ETVMailImpl _$$ETVMailImplFromJson(Map<String, dynamic> json) =>
    _$ETVMailImpl(
      $id: json[r'$id'] as String?,
      $databaseId: json[r'$databaseId'] as String?,
      $collectionId: json[r'$collectionId'] as String?,
      $createdAt: json[r'$createdAt'] as String?,
      $updatedAt: json[r'$updatedAt'] as String?,
      $permissions: (json[r'$permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      address: json['address'] as String,
      type: $enumDecodeNullable(_$MailTypeEnumMap, json['type']) ??
          MailType.active,
    );

Map<String, dynamic> _$$ETVMailImplToJson(_$ETVMailImpl instance) =>
    <String, dynamic>{
      r'$id': instance.$id,
      r'$databaseId': instance.$databaseId,
      r'$collectionId': instance.$collectionId,
      r'$createdAt': instance.$createdAt,
      r'$updatedAt': instance.$updatedAt,
      r'$permissions': instance.$permissions,
      'address': instance.address,
      'type': _$MailTypeEnumMap[instance.type]!,
    };

const _$MailTypeEnumMap = {
  MailType.active: 'active',
  MailType.unreachable: 'unreachable',
  MailType.removed: 'removed',
};
