// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'etv_mail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ETVMail _$ETVMailFromJson(Map<String, dynamic> json) {
  return _ETVMail.fromJson(json);
}

/// @nodoc
mixin _$ETVMail {
  String get uuid => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  MailType get type => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ETVMailCopyWith<ETVMail> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ETVMailCopyWith<$Res> {
  factory $ETVMailCopyWith(ETVMail value, $Res Function(ETVMail) then) =
      _$ETVMailCopyWithImpl<$Res, ETVMail>;
  @useResult
  $Res call(
      {String uuid,
      DateTime createdAt,
      String address,
      MailType type,
      String? reason});
}

/// @nodoc
class _$ETVMailCopyWithImpl<$Res, $Val extends ETVMail>
    implements $ETVMailCopyWith<$Res> {
  _$ETVMailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? createdAt = null,
    Object? address = null,
    Object? type = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MailType,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ETVMailImplCopyWith<$Res> implements $ETVMailCopyWith<$Res> {
  factory _$$ETVMailImplCopyWith(
          _$ETVMailImpl value, $Res Function(_$ETVMailImpl) then) =
      __$$ETVMailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      DateTime createdAt,
      String address,
      MailType type,
      String? reason});
}

/// @nodoc
class __$$ETVMailImplCopyWithImpl<$Res>
    extends _$ETVMailCopyWithImpl<$Res, _$ETVMailImpl>
    implements _$$ETVMailImplCopyWith<$Res> {
  __$$ETVMailImplCopyWithImpl(
      _$ETVMailImpl _value, $Res Function(_$ETVMailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? createdAt = null,
    Object? address = null,
    Object? type = null,
    Object? reason = freezed,
  }) {
    return _then(_$ETVMailImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MailType,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ETVMailImpl implements _ETVMail {
  _$ETVMailImpl(
      {required this.uuid,
      required this.createdAt,
      required this.address,
      this.type = MailType.active,
      this.reason});

  factory _$ETVMailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ETVMailImplFromJson(json);

  @override
  final String uuid;
  @override
  final DateTime createdAt;
  @override
  final String address;
  @override
  @JsonKey()
  final MailType type;
  @override
  final String? reason;

  @override
  String toString() {
    return 'ETVMail(uuid: $uuid, createdAt: $createdAt, address: $address, type: $type, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ETVMailImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, createdAt, address, type, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ETVMailImplCopyWith<_$ETVMailImpl> get copyWith =>
      __$$ETVMailImplCopyWithImpl<_$ETVMailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ETVMailImplToJson(
      this,
    );
  }
}

abstract class _ETVMail implements ETVMail {
  factory _ETVMail(
      {required final String uuid,
      required final DateTime createdAt,
      required final String address,
      final MailType type,
      final String? reason}) = _$ETVMailImpl;

  factory _ETVMail.fromJson(Map<String, dynamic> json) = _$ETVMailImpl.fromJson;

  @override
  String get uuid;
  @override
  DateTime get createdAt;
  @override
  String get address;
  @override
  MailType get type;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$ETVMailImplCopyWith<_$ETVMailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
